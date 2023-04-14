use core::cell::UnsafeCell;
mod bbq_ipc;
use bbq_ipc::*;
// LIBRARY_TYPE=relocatable alr build
// eval $(alr -q printenv --unix)
// LD_LIBRARY_PATH=printer/lib cargo run
extern "C" {
    fn fill();
}

// Could be static, or heap initialized, needs to live
// as long as both A and B exist

fn main() {
    let bbq: BBBuffer = BBBuffer::new();
    println!("BBBuffer bbq {:?}", bbq);
    let data: UnsafeCell<[u8; 1024]> = UnsafeCell::new([0u8; 1024]);
    println!("data {:?}", data);
    // Ok this is gross but I guess I need it?
    // how to get that heap allocated
    let buf_ptr = (&bbq as *const BBBuffer).cast_mut();

    println!("buf_ptr {:?}", buf_ptr);
    let producer = unsafe {
        // initialize ONCE
        //fn initialize(&'a self, buf_start: *mut u8, buf_len: usize)
        bbq.initialize(data.get().cast::<u8>(), 1024);
        BBBuffer::take_producer(buf_ptr)
    };

    let grant = producer.grant_exact(4).unwrap();
    println!("producer {:?}", producer);
    println!("grant {:?}", grant);
    unsafe {
        fill();
    }
}
