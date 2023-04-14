mod bbq_ipc;
use bbq_ipc::*;
// LIBRARY_TYPE=relocatable alr build
// eval $(alr -q printenv --unix)
// LD_ ...
extern "C" {
    fn fill(w: GrantW, s: i32);
}
fn main() {
    //let mut bb = BBBuffer::new();
    //bb.initialize(0, 4);
    //let mut prod = unsafe { bbbuffer::BBBuffer::take_producer(&mut bb) };
    //let mut grant = prod.grant_exact(1).unwrap();

    unsafe {
        fill(grant, 4);
    }
}
