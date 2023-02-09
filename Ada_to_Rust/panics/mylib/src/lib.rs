#[no_mangle]
extern "C" fn panicking() {
    println!("I am just panicking!");
    panic!();
    return;
}
