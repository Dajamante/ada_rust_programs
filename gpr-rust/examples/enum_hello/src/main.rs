#[repr(C)]
enum TwoEnum {
    One,
    Two,
}
#[no_mangle]
extern "C" {
    fn enum_hello(one: TwoEnum, two: TwoEnum);
}

fn main() {
    let one = TwoEnum::One;
    let two = TwoEnum::Two;
    unsafe {
        enum_hello(one, two);
    }
}
