use core::{cell::UnsafeCell, ptr::NonNull};
mod bbq_ipc;
use bbq_ipc::*;
use std::os::raw::c_char;
// in printer/: LIBRARY_TYPE=relocatable alr build
// still in printer/: eval $(alr -q printenv --unix)
// outside printer: LD_LIBRARY_PATH=printer/lib cargo run
extern "C" {
    // `extern` block uses type `bbbuffer::GrantW<'_>`, which is not FFI-safe
    fn fill(g: RustGrantR);
}

#[derive(Debug)]
#[repr(C)]
struct InnerBuf {
    ptr: *mut c_char,
    size: usize,
}

#[repr(C)]
struct RustGrantW {
    inner: InnerBuf,
    bbq: NonNull<bbbuffer::BBBuffer>, // Pointer to the original queue
    to_commit: usize,
}
#[repr(C)]
struct RustGrantR {
    inner: *mut u8,
    bbq: *mut BBBuffer, // Pointer to the original queue
                        //to_release: usize,
}

fn main() {
    let bbq: Box<BBBuffer> = Box::new(BBBuffer::new());

    println!("bbq {:?}\n", bbq);
    let data: Box<UnsafeCell<[u8; 128]>> = Box::new(UnsafeCell::new([0u8; 128]));
    println!("Inner data {:?}\n", data);

    let buf_ptr = Box::into_raw(bbq);
    println!("buf_ptr: {:?}\n", buf_ptr);
    let producer = unsafe {
        (*buf_ptr).initialize(data.as_ref().get().cast::<u8>(), 128);
        BBBuffer::take_producer(buf_ptr)
    };

    let mut w_grant = producer.grant_exact(4).unwrap();
    w_grant[0] = 42;
    w_grant.commit(4);
    let consumer = unsafe { BBBuffer::take_consumer(buf_ptr) };
    let r_grant = consumer.read().unwrap();
    // let inner = InnerBuf {
    //     ptr: grant.buf.as_ptr() as *mut c_char,
    //     size: grant.buf.len(),
    // };
    println!(
        "r_grant.buf.as_mut_ptr(): {:?}\n",
        r_grant.buf.as_ptr() as *mut u8
    );

    println!("last {:?}", buf_ptr);
    let ada_grantr = RustGrantR {
        inner: r_grant.buf.as_ptr() as *mut u8,
        bbq: buf_ptr,
        //to_release: r_grant.to_release,
    };
    unsafe {
        fill(ada_grantr);
    }
}
