// Don't forget no_mangle or it is not found.
// Make sure there is no overflow would be a recommendation
// Handle the error apropriately to not allow undefined behavious
// at the FFI border.
#[no_mangle]
//pub extern "C" fn add(x: &mut i32, y: &mut i32, z: &mut i32) {
pub extern "C" fn add(x: i32, y: i32) -> i32 {
    //*z = *x + *y + *y;
    x + y
}
