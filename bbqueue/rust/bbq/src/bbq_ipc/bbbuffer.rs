use crate::bbq_ipc::{
    framed::{FrameConsumer, FrameProducer},
    Error, Result,
};
use core::{
    cmp::min,
    marker::PhantomData,
    mem::{forget, transmute},
    ops::{Deref, DerefMut},
    ptr::NonNull,
    slice::from_raw_parts_mut,
    sync::atomic::{
        compiler_fence, AtomicBool, AtomicPtr, AtomicUsize,
        Ordering::{AcqRel, Acquire, Relaxed, Release, SeqCst},
    },
};
#[derive(Debug)]
#[repr(C)]
/// A backing structure for a BBQueue. Can be used to create either
/// a BBQueue or a split Producer/Consumer pair
pub struct BBBuffer {
    buf: AtomicPtr<u8>,

    buf_len: AtomicUsize,

    /// Where the next byte will be written
    write: AtomicUsize,

    /// Where the next byte will be read from
    read: AtomicUsize,

    /// Used in the inverted case to mark the end of the
    /// readable streak. Otherwise will == sizeof::<self.buf>().
    /// Writer is responsible for placing this at the correct
    /// place when entering an inverted condition, and Reader
    /// is responsible for moving it back to sizeof::<self.buf>()
    /// when exiting the inverted condition
    last: AtomicUsize,

    /// Used by the Writer to remember what bytes are currently
    /// allowed to be written to, but are not yet ready to be
    /// read from
    reserve: AtomicUsize,

    /// Is there an active read grant?
    read_in_progress: AtomicBool,

    /// Is there an active write grant?
    write_in_progress: AtomicBool,
}

unsafe impl Sync for BBBuffer {}

impl<'a> BBBuffer {
    pub unsafe fn initialize(&'a self, buf_start: *mut u8, buf_len: usize) {
        compiler_fence(SeqCst);
        buf_start.write_bytes(0u8, buf_len);
        self.buf_len.store(buf_len, SeqCst);
        self.buf.store(buf_start, SeqCst);
    }

    #[inline]
    pub unsafe fn take_producer(me: *mut Self) -> Producer<'static> {
        let nn_me = NonNull::new_unchecked(me);
        Producer {
            bbq: nn_me,
            pd: PhantomData,
        }
    }

    #[inline]
    pub unsafe fn take_consumer(me: *mut Self) -> Consumer<'static> {
        let nn_me = NonNull::new_unchecked(me);
        Consumer {
            bbq: nn_me,
            pd: PhantomData,
        }
    }

    #[inline]
    pub unsafe fn take_framed_producer(me: *mut Self) -> FrameProducer<'static> {
        let nn_me = NonNull::new_unchecked(me);
        FrameProducer {
            producer: Producer {
                bbq: nn_me,
                pd: PhantomData,
            },
        }
    }

    #[inline]
    pub unsafe fn take_framed_consumer(me: *mut Self) -> FrameConsumer<'static> {
        let nn_me = NonNull::new_unchecked(me);
        FrameConsumer {
            consumer: Consumer {
                bbq: nn_me,
                pd: PhantomData,
            },
        }
    }
}

impl BBBuffer {
    pub const fn new() -> Self {
        Self {
            // This will not be initialized until we split the buffer
            buf: AtomicPtr::new(core::ptr::null_mut()),

            buf_len: AtomicUsize::new(0),

            /// Owned by the writer
            write: AtomicUsize::new(0),

            /// Owned by the reader
            read: AtomicUsize::new(0),

            last: AtomicUsize::new(0),

            /// Owned by the Writer, "private"
            reserve: AtomicUsize::new(0),

            /// Owned by the Reader, "private"
            read_in_progress: AtomicBool::new(false),

            /// Owned by the Writer, "private"
            write_in_progress: AtomicBool::new(false),
        }
    }
}

pub struct Producer<'a> {
    bbq: NonNull<BBBuffer>,
    pd: PhantomData<&'a ()>,
}

unsafe impl<'a> Send for Producer<'a> {}
unsafe impl<'a> Sync for Producer<'a> {}

impl<'a> Producer<'a> {
    pub fn grant_exact(&self, sz: usize) -> Result<GrantW<'a>> {
        let inner = unsafe { &self.bbq.as_ref() };

        if atomic::swap(&inner.write_in_progress, true, AcqRel) {
            return Err(Error::GrantInProgress);
        }

        let write = inner.write.load(Acquire);
        let read = inner.read.load(Acquire);
        let max = inner.buf_len.load(Relaxed);
        let already_inverted = write < read;

        let start = if already_inverted {
            if (write + sz) < read {
                write
            } else {
                inner.write_in_progress.store(false, Release);
                return Err(Error::InsufficientSize);
            }
        } else if write + sz <= max {
            write
        } else {
            if sz < read {
                // Invertible situation
                0
            } else {
                // Not invertible, no space
                inner.write_in_progress.store(false, Release);
                return Err(Error::InsufficientSize);
            }
        };
        // Safe write, only viewed by this task
        inner.reserve.store(start + sz, Release);

        let start_of_buf_ptr = inner.buf.load(Relaxed);
        let grant_slice = unsafe { from_raw_parts_mut(start_of_buf_ptr.add(start), sz) };

        Ok(GrantW {
            buf: grant_slice,
            bbq: self.bbq,
            to_commit: 0,
        })
    }

    #[allow(dead_code)]
    pub fn grant_max_remaining(&self, mut sz: usize) -> Result<GrantW<'a>> {
        let inner = unsafe { &self.bbq.as_ref() };

        if atomic::swap(&inner.write_in_progress, true, AcqRel) {
            return Err(Error::GrantInProgress);
        }

        // Writer component. Must never write to `read`,
        // be careful writing to `load`
        let write = inner.write.load(Acquire);
        let read = inner.read.load(Acquire);
        let max = inner.buf_len.load(Relaxed);

        let already_inverted = write < read;

        let start = if already_inverted {
            // In inverted case, read is always > write
            let remain = read - write - 1;

            if remain != 0 {
                sz = min(remain, sz);
                write
            } else {
                // Inverted, no room is available
                inner.write_in_progress.store(false, Release);
                return Err(Error::InsufficientSize);
            }
        } else if write != max {
            // Some (or all) room remaining in un-inverted case
            sz = min(max - write, sz);
            write
        } else {
            // Not inverted, but need to go inverted

            // NOTE: We check read > 1, NOT read >= 1, because
            // write must never == read in an inverted condition, since
            // we will then not be able to tell if we are inverted or not
            if read > 1 {
                sz = min(read - 1, sz);
                0
            } else {
                // Not invertible, no space
                inner.write_in_progress.store(false, Release);
                return Err(Error::InsufficientSize);
            }
        };

        // Safe write, only viewed by this task
        inner.reserve.store(start + sz, Release);

        // This is sound, as UnsafeCell, MaybeUninit, and GenericArray
        // are all `#[repr(Transparent)]
        let start_of_buf_ptr = inner.buf.load(Relaxed);
        let grant_slice = unsafe { from_raw_parts_mut(start_of_buf_ptr.add(start), sz) };

        Ok(GrantW {
            buf: grant_slice,
            bbq: self.bbq,
            to_commit: 0,
        })
    }
}

/// `Consumer` is the primary interface for reading data from a `BBBuffer`.
pub struct Consumer<'a> {
    bbq: NonNull<BBBuffer>,
    pd: PhantomData<&'a ()>,
}

unsafe impl<'a> Send for Consumer<'a> {}
unsafe impl<'a> Sync for Consumer<'a> {}

impl<'a> Consumer<'a> {
    pub fn read(&self) -> Result<GrantR<'a>> {
        let inner = unsafe { &self.bbq.as_ref() };

        if atomic::swap(&inner.read_in_progress, true, AcqRel) {
            return Err(Error::GrantInProgress);
        }

        let write = inner.write.load(Acquire);
        let last = inner.last.load(Acquire);
        let mut read = inner.read.load(Acquire);

        // Resolve the inverted case or end of read
        if (read == last) && (write < read) {
            read = 0;

            inner.read.store(0, Release);
        }

        let sz = if write < read {
            // Inverted, only believe last
            last
        } else {
            // Not inverted, only believe write
            write
        } - read;

        if sz == 0 {
            inner.read_in_progress.store(false, Release);
            return Err(Error::InsufficientSize);
        }

        let start_of_buf_ptr = inner.buf.load(Relaxed);
        let grant_slice = unsafe { from_raw_parts_mut(start_of_buf_ptr.add(read), sz) };

        Ok(GrantR {
            buf: grant_slice,
            bbq: self.bbq,
            to_release: 0,
        })
    }

    #[allow(dead_code)] // TODO(AJM): Not used in mnemos
    pub fn split_read(&self) -> Result<SplitGrantR<'a>> {
        let inner = unsafe { &self.bbq.as_ref() };

        if atomic::swap(&inner.read_in_progress, true, AcqRel) {
            return Err(Error::GrantInProgress);
        }

        let write = inner.write.load(Acquire);
        let last = inner.last.load(Acquire);
        let mut read = inner.read.load(Acquire);

        // Resolve the inverted case or end of read
        if (read == last) && (write < read) {
            read = 0;

            inner.read.store(0, Release);
        }

        let (sz1, sz2) = if write < read {
            // Inverted, only believe last
            (last - read, write)
        } else {
            // Not inverted, only believe write
            (write - read, 0)
        };

        if sz1 == 0 {
            inner.read_in_progress.store(false, Release);
            return Err(Error::InsufficientSize);
        }

        let start_of_buf_ptr = inner.buf.load(Relaxed);
        let grant_slice1 = unsafe { from_raw_parts_mut(start_of_buf_ptr.add(read), sz1) };
        let grant_slice2 = unsafe { from_raw_parts_mut(start_of_buf_ptr, sz2) };

        Ok(SplitGrantR {
            buf1: grant_slice1,
            buf2: grant_slice2,
            bbq: self.bbq,
            to_release: 0,
        })
    }
}

#[derive(Debug, PartialEq)]
pub struct GrantW<'a> {
    pub(crate) buf: &'a mut [u8],
    bbq: NonNull<BBBuffer>,
    pub(crate) to_commit: usize,
}

unsafe impl<'a> Send for GrantW<'a> {}

#[derive(Debug, PartialEq)]
pub struct GrantR<'a> {
    pub(crate) buf: &'a mut [u8],
    bbq: NonNull<BBBuffer>,
    pub(crate) to_release: usize,
}

/// A structure representing up to two contiguous regions of memory that
/// may be read from, and potentially "released" (or cleared)
/// from the queue
#[derive(Debug, PartialEq)]
pub struct SplitGrantR<'a> {
    pub(crate) buf1: &'a mut [u8],
    pub(crate) buf2: &'a mut [u8],
    bbq: NonNull<BBBuffer>,
    pub(crate) to_release: usize,
}

unsafe impl<'a> Send for GrantR<'a> {}

unsafe impl<'a> Send for SplitGrantR<'a> {}

impl<'a> GrantW<'a> {
    pub fn commit(mut self, used: usize) {
        self.commit_inner(used);
        forget(self);
    }

    pub fn buf(&mut self) -> &mut [u8] {
        self.buf
    }

    pub unsafe fn as_static_mut_buf(&mut self) -> &'static mut [u8] {
        transmute::<&mut [u8], &'static mut [u8]>(self.buf)
    }

    #[inline(always)]
    pub(crate) fn commit_inner(&mut self, used: usize) {
        let inner = unsafe { &self.bbq.as_ref() };

        // If there is no grant in progress, return early. This
        // generally means we are dropping the grant within a
        // wrapper structure
        if !inner.write_in_progress.load(Acquire) {
            return;
        }

        let len = self.buf.len();
        let used = min(len, used);

        let write = inner.write.load(Acquire);
        atomic::fetch_sub(&inner.reserve, len - used, AcqRel);

        let max = inner.buf_len.load(Relaxed);
        let last = inner.last.load(Acquire);
        let new_write = inner.reserve.load(Acquire);

        if (new_write < write) && (write != max) {
            inner.last.store(write, Release);
        } else if new_write > last {
            inner.last.store(max, Release);
        }

        inner.write.store(new_write, Release);

        // Allow subsequent grants
        inner.write_in_progress.store(false, Release);
    }

    /// Configures the amount of bytes to be commited on drop.
    pub fn to_commit(&mut self, amt: usize) {
        self.to_commit = self.buf.len().min(amt);
    }
}

impl<'a> GrantR<'a> {
    pub fn release(mut self, used: usize) {
        // Saturate the grant release
        let used = min(self.buf.len(), used);

        self.release_inner(used);
        forget(self);
    }

    pub(crate) fn shrink(&mut self, len: usize) {
        let mut new_buf: &mut [u8] = &mut [];
        core::mem::swap(&mut self.buf, &mut new_buf);
        let (new, _) = new_buf.split_at_mut(len);
        self.buf = new;
    }

    pub fn buf(&self) -> &[u8] {
        self.buf
    }

    pub fn buf_mut(&mut self) -> &mut [u8] {
        self.buf
    }

    pub unsafe fn as_static_buf(&self) -> &'static [u8] {
        transmute::<&[u8], &'static [u8]>(self.buf)
    }

    #[inline(always)]
    pub(crate) fn release_inner(&mut self, used: usize) {
        let inner = unsafe { &self.bbq.as_ref() };

        if !inner.read_in_progress.load(Acquire) {
            return;
        }

        // This should always be checked by the public interfaces
        debug_assert!(used <= self.buf.len());

        // This should be fine, purely incrementing
        let _ = atomic::fetch_add(&inner.read, used, Release);

        inner.read_in_progress.store(false, Release);
    }

    pub fn to_release(&mut self, amt: usize) {
        self.to_release = self.buf.len().min(amt);
    }
}

impl<'a> SplitGrantR<'a> {
    pub fn release(mut self, used: usize) {
        // Saturate the grant release
        let used = min(self.combined_len(), used);

        self.release_inner(used);
        forget(self);
    }

    pub fn bufs(&self) -> (&[u8], &[u8]) {
        (self.buf1, self.buf2)
    }

    pub fn bufs_mut(&mut self) -> (&mut [u8], &mut [u8]) {
        (self.buf1, self.buf2)
    }

    #[inline(always)]
    pub(crate) fn release_inner(&mut self, used: usize) {
        let inner = unsafe { &self.bbq.as_ref() };

        if !inner.read_in_progress.load(Acquire) {
            return;
        }

        debug_assert!(used <= self.combined_len());

        if used <= self.buf1.len() {
            let _ = atomic::fetch_add(&inner.read, used, Release);
        } else {
            inner.read.store(used - self.buf1.len(), Release);
        }

        inner.read_in_progress.store(false, Release);
    }

    pub fn to_release(&mut self, amt: usize) {
        self.to_release = self.combined_len().min(amt);
    }

    pub fn combined_len(&self) -> usize {
        self.buf1.len() + self.buf2.len()
    }
}

impl<'a> Drop for GrantW<'a> {
    fn drop(&mut self) {
        self.commit_inner(self.to_commit)
    }
}

impl<'a> Drop for GrantR<'a> {
    fn drop(&mut self) {
        self.release_inner(self.to_release)
    }
}

impl<'a> Drop for SplitGrantR<'a> {
    fn drop(&mut self) {
        self.release_inner(self.to_release)
    }
}

impl<'a> Deref for GrantW<'a> {
    type Target = [u8];

    fn deref(&self) -> &Self::Target {
        self.buf
    }
}

impl<'a> DerefMut for GrantW<'a> {
    fn deref_mut(&mut self) -> &mut [u8] {
        self.buf
    }
}

impl<'a> Deref for GrantR<'a> {
    type Target = [u8];

    fn deref(&self) -> &Self::Target {
        self.buf
    }
}

impl<'a> DerefMut for GrantR<'a> {
    fn deref_mut(&mut self) -> &mut [u8] {
        self.buf
    }
}
