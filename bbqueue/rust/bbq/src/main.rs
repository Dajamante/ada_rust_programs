use core::cell::UnsafeCell;
mod bbq_ipc;
use bbq_ipc::*;
// LIBRARY_TYPE=relocatable alr build
// eval $(alr -q printenv --unix)
// LD_ ...
extern "C" {
    fn fill(w: GrantW, s: i32);
}

// Could be static, or heap initialized, needs to live
// as long as both A and B exist

fn main() {
    let BUF: BBBuffer = BBBuffer::new();
    let DATA: UnsafeCell<[u8; 1024]> = UnsafeCell::new([0u8; 1024]);
    //let mut bb = BBBuffer::new();
    //bb.initialize(0, 4);
    //let mut prod = unsafe { bbbuffer::BBBuffer::take_producer(&mut bb) };
    //let mut grant = prod.grant_exact(1).unwrap();
    // This is gross, sorry
    let buf_ptr = (&BUF as *const BBBuffer).cast_mut();

    let producer = unsafe {
        // initialize ONCE
        BUF.initialize(DATA.get().cast::<u8>(), 1024);
        BBBuffer::take_producer(buf_ptr)
    };

    let grant = producer.grant_exact(4).unwrap();
    unsafe {
        fill(grant, 4);
    }
}
