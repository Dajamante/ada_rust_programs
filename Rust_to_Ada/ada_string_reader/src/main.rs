extern "C" {
    fn ada_sender() -> String;
}
fn main() {
    unsafe {
        let s = ada_sender();
        println!("Hello, {}!", s);
    }
}
