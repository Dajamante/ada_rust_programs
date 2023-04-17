use core::{cell::UnsafeCell, ptr::NonNull};
mod bbq_ipc;
use bbq_ipc::*;
use std::os::raw::c_char;
// in printer/: LIBRARY_TYPE=relocatable alr build
// still in printer/: eval $(alr -q printenv --unix)
// outside printer: LD_LIBRARY_PATH=printer/lib cargo run
extern "C" {
    // `extern` block uses type `bbbuffer::GrantW<'_>`, which is not FFI-safe
    fn fill(g: AdaGrantW);
}

#[derive(Debug)]
#[repr(C)]
struct InnerBuf {
    // ptr: *mut c_char,
    size: usize,
}

#[repr(C)]
struct AdaGrantW {
    bbq: NonNull<bbbuffer::BBBuffer>,
    inner: InnerBuf,
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

    let grant = producer.grant_exact(4).unwrap();
    println!("{:?} \n", producer);
    println!("{:?} \n", grant);

    println!("Grant buf {:?} \n", grant.buf);
    let inner = InnerBuf {
        //ptr: grant.buf.as_ptr() as *mut c_char,
        size: grant.buf.len(),
    };
    println!("Inner buf {:?} \n", inner);

    let ada_grantw = AdaGrantW {
        bbq: grant.bbq,
        inner: inner,
    };
    unsafe {
        fill(ada_grantw);
    }
}
