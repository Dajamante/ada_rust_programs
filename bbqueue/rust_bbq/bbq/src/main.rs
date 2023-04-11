#[no_mangle]
extern "C" {
    fn print_content(a: &[i32]);
}
fn main() {
    println!("Hello, world!");
    let a = [1, 3];
    unsafe {
        print_content(&a);
    }
}
