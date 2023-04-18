use core::{cell::UnsafeCell, ptr::NonNull};
mod bbq_ipc;
use bbq_ipc::*;
use std::os::raw::c_char;
// in printer/: LIBRARY_TYPE=relocatable alr build
// still in printer/: eval $(alr -q printenv --unix)
// outside printer: LD_LIBRARY_PATH=printer/lib cargo run
extern "C" {
    // `extern` block uses type `bbbuffer::GrantW<'_>`, which is not FFI-safe
    fn fill(g: *const RustReadGrant);
}

#[repr(C)]
struct RustReadGrant {
    bbq: *mut BBBuffer, // Pointer to the original queue
    inner: *mut u8,
    buf_len: u64,
}

fn main() {
    let bbq: Box<BBBuffer> = Box::new(BBBuffer::new());
    let data: Box<UnsafeCell<[u8; 128]>> = Box::new(UnsafeCell::new([0u8; 128]));
    let buf_ptr = Box::into_raw(bbq);
    let producer = unsafe {
        (*buf_ptr).initialize(data.as_ref().get().cast::<u8>(), 128);
        BBBuffer::take_producer(buf_ptr)
    };

    let mut w_grant = producer.grant_exact(4).unwrap();
    w_grant[0] = 42;
    w_grant[1] = 43;
    w_grant[2] = 44;
    w_grant[3] = 45;

    w_grant.commit(4);
    let consumer = unsafe { BBBuffer::take_consumer(buf_ptr) };
    let r_grant = consumer.read().unwrap();
    println!("last buf_ptr: {:?}", buf_ptr);
    println!("r_grant.buf: {:?}\n", r_grant.buf.as_mut_ptr());

    let rust_rgrant = Box::new(RustReadGrant {
        bbq: buf_ptr,
        inner: r_grant.buf.as_ptr() as *mut u8,
        buf_len: r_grant.buf.len() as u64,
    });

    //println!("ada_grantr.bbq: {:p}", ada_grantr.bbq);
    //println!("ada_grantr.inner: {:p}", ada_grantr.inner);
    //println!("ada_grantr.buf_len: {}", ada_grantr.buf_len);
    unsafe {
        fill(Box::into_raw(rust_rgrant));
    }
}
