#[repr(C)]
#[derive(Debug)]
enum Dog {
    SmallDog,
    BigDog,
}

//No, this is working correctly. #[no_mangle] does nothing on extern items, which already do not get mangled, even without the attribute.
// https://github.com/rust-lang/rust/issues/78989
extern "C" {
    fn send_enum() -> Dog;
}

fn main() {
    unsafe {
        let dog = send_enum();
        println!("Hello, {:?}!", dog);
    }
}
