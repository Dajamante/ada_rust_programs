use core::cell::UnsafeCell;
mod bbq_ipc;
use bbq_ipc::*;
use std::thread;
//static BUF: BBBuffer = BBBuffer::new();
//static DATA: UnsafeCell<[u8; 32]> = UnsafeCell::new([0u8; 32]);
//static DATA: RefCell<Vec<u8>> = RefCell::new(Vec::new());
fn main() {
    //let buf_ptr = (&BUF as *const BBBuffer).cast_mut();
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

    let consumer = unsafe { BBBuffer::take_consumer(buf_ptr) };

    let tx = thread::spawn(move || loop {
        //let mut w_grant = producer.grant_exact(1).unwrap();
        match producer.grant_exact(1) {
            Ok(mut w_grant) => {
                println!("{:?} \n", w_grant);
                w_grant[0] = 42;
                w_grant.commit(1);
            }
            Err(e) => println!("{:?}", e),
        }
    });

    let rx = thread::spawn(move || loop {
        //let mut r_grant = consumer.read();

        match consumer.read() {
            Ok(r_grant) => {
                println!("{:?} \n", r_grant);
                r_grant.release(1);
            }
            Err(e) => println!("{:?}", e),
        }
    });

    tx.join();
    rx.join();
}
