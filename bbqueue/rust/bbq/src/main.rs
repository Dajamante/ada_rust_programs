use core::cell::UnsafeCell;
mod bbq_ipc;
use bbq_ipc::*;
use std::mem;
#[allow(dead_code)]

extern "C" {
    fn read_queue(g: *const RustReadGrant);
}

#[repr(C)]
struct RustReadGrant {
    bbq: *mut BBBuffer, // Pointer to the original queue, it is mut to respect the original design
    inner: *mut u8,
    buf_len: usize,
}

fn main() {
    let bbq: Box<BBBuffer> = Box::new(BBBuffer::new());
    println!("Size of bbq: {} bytes", mem::size_of::<Box<BBBuffer>>());

    let data: Box<UnsafeCell<[u8; 128]>> = Box::new(UnsafeCell::new([0u8; 128]));

    println!(
        "Size of Box<UnsafeCell<[u8; 128]>>: {} bytes",
        mem::size_of::<Box<UnsafeCell<[u8; 128]>>>()
    );

    let buf_ptr = Box::into_raw(bbq);

    let producer: Producer = unsafe {
        (*buf_ptr).initialize(data.as_ref().get().cast::<u8>(), 128);
        BBBuffer::take_producer(buf_ptr)
    };
    println!("Size of Producer: {} bytes", mem::size_of::<Producer>());
    let mut w_grant: GrantW = producer.grant_exact(4).unwrap();

    println!("Size of GrantW: {} bytes", mem::size_of::<GrantW>());
    w_grant[0] = 42;
    w_grant[1] = 43;
    w_grant[2] = 44;
    w_grant[3] = 45;

    w_grant.commit(4);

    let consumer: Consumer = unsafe { BBBuffer::take_consumer(buf_ptr) };
    println!("Size of Consumer: {} bytes", mem::size_of::<Consumer>());

    let r_grant: GrantR = consumer.read().unwrap();
    println!("last buf_ptr: {:?}", buf_ptr);
    println!("r_grant.buf: {:?}\n", r_grant.buf.as_mut_ptr());
    println!("Size of GrantR: {} bytes", mem::size_of::<GrantR>());

    let rust_rgrant = Box::new(RustReadGrant {
        bbq: buf_ptr,
        inner: r_grant.buf.as_ptr() as *mut u8,
        buf_len: r_grant.buf.len(),
    });
    println!(
        "Size of RustReadGrant: {} bytes",
        mem::size_of::<RustReadGrant>()
    );

    //println!("ada_grantr.bbq: {:p}", ada_grantr.bbq);
    //println!("ada_grantr.inner: {:p}", ada_grantr.inner);
    //println!("ada_grantr.buf_len: {}", ada_grantr.buf_len);
    // could the error be because of pass by value?
    let pt = Box::into_raw(rust_rgrant);
    println!("rust_rgrant structure: {:p}", pt);
    println!(
        "Size of *const RustReadGrant: {} bytes",
        mem::size_of::<*const RustReadGrant>()
    );
    unsafe {
        read_queue(pt);
    }
    r_grant.release(4);
}
