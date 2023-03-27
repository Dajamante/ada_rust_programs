// Needs no mangle
// Shows that division by zero is possible
// Shows that we cannot enforce the garantees
// Offered by SPARK (preconditions or asserts.)
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
