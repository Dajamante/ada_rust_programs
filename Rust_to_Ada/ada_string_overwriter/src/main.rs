extern "C" {
    fn replace() -> [u8; 5];
}
fn main() {
    unsafe {
        let s = replace();
        println!("Hello, {:?}!", s.to_vec());
    }
}
