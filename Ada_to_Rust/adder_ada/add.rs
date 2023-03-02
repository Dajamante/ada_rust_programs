#[no_mangle]
pub extern "C" fn add(x: &mut i32, y: &mut i32, z: &mut i32) {
    *z = *x + *y;
}
