extern "C" {
    fn ada_sender() -> [u8; 5];
}
fn main() {
    unsafe {
        let s = ada_sender();
        println!("Hello, {:?}!", s);
    }
}
