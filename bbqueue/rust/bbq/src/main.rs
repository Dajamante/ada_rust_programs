extern "C" {
    fn fill();
}
fn main() {
    println!("Hello, world!");
    unsafe {
        fill();
    }
}
