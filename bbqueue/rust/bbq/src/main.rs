use core::cell::UnsafeCell;
mod bbq_ipc;
use bbq_ipc::*;
// in printer/: LIBRARY_TYPE=relocatable alr build
// still in printer/: eval $(alr -q printenv --unix)
// outside printer: LD_LIBRARY_PATH=printer/lib cargo run
extern "C" {
    // `extern` block uses type `bbbuffer::GrantW<'_>`, which is not FFI-safe
    fn fill(g: GrantW);
}

// Could be static, or heap initialized, needs to live
// as long as both A and B exist

fn main() {
    //let bbq: BBBuffer = BBBuffer::new();
    let bbq: Box<BBBuffer> = Box::new(BBBuffer::new());

    println!("bbq {:?}\n", bbq);
    //let data: UnsafeCell<[u8; 1024]> = UnsafeCell::new([0u8; 1024]);
    let data: Box<UnsafeCell<[u8; 1024]>> = Box::new(UnsafeCell::new([0u8; 1024]));
    println!("Inner data {:?}\n", data);
    // Ok this is gross but I guess I need it?
    // how to get that heap allocated
    //let buf_ptr = (&bbq as *const BBBuffer).cast_mut();
    let buf_ptr = Box::into_raw(bbq);
    println!("buf_ptr: {:?}\n", buf_ptr);
    let producer = unsafe {
        // initialize ONCE
        // Signature:
        //fn initialize(&'a self, buf_start: *mut u8, buf_len: usize)
        //bbq.initialize(data.get().cast::<u8>(), 1024);
        (*buf_ptr).initialize(data.as_ref().get().cast::<u8>(), 1024);
        BBBuffer::take_producer(buf_ptr)
    };

    let grant = producer.grant_exact(4).unwrap();
    println!("{:?} \n", producer);
    println!("{:?} \n", grant);
    // we probably need to do the commit!
    // grant is moved into commit
    //  This consumes the grant.
    // let grant = grant.commit(1);
    unsafe {
        fill(grant);
    }
    // we probably need to forget the grant here?
    // std::mem::forget(grant);
    // even looping to prevent the holder to go out of scope produce the same error
    // loop {}
}
