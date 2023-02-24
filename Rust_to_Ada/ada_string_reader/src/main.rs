extern "C" {
    fn ada_sender() -> [u8; 5];
}
fn main() {
    unsafe {
        let s = ada_sender();
        println!(
            "Hello, {:?}!",
            s.map(|c| TryInto::<char>::try_into(c).unwrap())
        );
    }
}
