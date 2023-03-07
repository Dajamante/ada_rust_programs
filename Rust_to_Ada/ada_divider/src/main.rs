extern "C" {
    fn divide(x: i32, y: i32) -> i32;
}

fn main() {
    unsafe {
        let x = 1;
        let y = 0;
        let z = divide(x, y);
        println!("Hello, Z {:?}!", z);
    }
}
