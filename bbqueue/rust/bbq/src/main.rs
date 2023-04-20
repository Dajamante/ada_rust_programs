use core::{cell::UnsafeCell, ptr::NonNull, sync::atomic::Ordering};

mod bbq_ipc;
use bbq_ipc::*;
use std::mem;
#[allow(dead_code)]
#[no_mangle]
pub extern "C" fn send_bbq_data(bbq: &BBBuffer) -> *const BBBuffer {
    bbq as *const BBBuffer
}

extern "C" {
    fn read_queue(g: *const RustReadGrant);
    //fn send_bbq_data(bbq: &BBBuffer) -> (usize, usize, usize, usize, bool, bool);
}

#[repr(C)]
struct RustReadGrant {
    bbq: NonNull<BBBuffer>, // Pointer to the original queue, it is mut to respect the original design
    inner: *mut u8,
    buf_len: usize,
}

fn main() {
    let bbq: Box<BBBuffer> = Box::new(BBBuffer::new());
    println!(
        "Size of Box<BBBuffer>: {} bytes",
        mem::size_of::<Box<BBBuffer>>()
    );
    println!("Size of BBBuffer: {} bytes", mem::size_of::<BBBuffer>());
    println!("My bbq: {:?} ", bbq);

    let data: Box<UnsafeCell<[u8; 128]>> = Box::new(UnsafeCell::new([0u8; 128]));

    println!(
        "Size of Box<UnsafeCell<[u8; 128]>>: {} bytes",
        mem::size_of::<Box<UnsafeCell<[u8; 128]>>>()
    );
    println!(
        "Size of UnsafeCell<[u8; 128]>: {} bytes",
        mem::size_of::<UnsafeCell<[u8; 128]>>()
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
        bbq: NonNull::new(buf_ptr).expect("failed to create NonNull pointer"),
        inner: r_grant.buf.as_ptr() as *mut u8,
        buf_len: r_grant.buf.len(),
    });
    println!(
        "Size of RustReadGrant: {} bytes",
        mem::size_of::<RustReadGrant>()
    );

    // could the error be because of pass by value?
    let pt = Box::into_raw(rust_rgrant);
    println!("rust_rgrant structure: {:p}", pt);
    println!(
        "Size of *const RustReadGrant: {} bytes",
        mem::size_of::<*const RustReadGrant>()
    );
    unsafe {
        //send_bbq_data(&*buf_ptr); // reconstructing &bbq moved into Box!

        read_queue(pt);
    }
    r_grant.release(4);
}
