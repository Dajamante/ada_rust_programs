// Making an explicit panic at the ffi that will unwind on the
// other side, this is undefined behaviour.
#[no_mangle]
extern "C" fn panicking() {
    println!("I am just panicking!");
    panic!();
    return;
}
