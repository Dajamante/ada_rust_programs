extern "C" {
    fn swap(x: &mut i32, y: &mut i32);
}
fn main() {
    unsafe {
        let mut x = 1;
        let mut y = 2;
        println!("Hello, x: {x}, y: {y}!");
        swap(&mut x, &mut y);
        println!("Hello, x: {x}, y: {y}!");
    }
}
