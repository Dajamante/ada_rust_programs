/* 2 | pub extern C fn swap(x: &mut i16, &mut i16){
    |            ^ expected one of `crate` or `{`
        Not C but "C"
        Forgot to add y... x: &mut i16, y: &mut i16 and not x: &mut i16,&mut i16
*/
#[no_mangle]
pub extern "C" fn swap(x: &mut i32, y: &mut i32) {
    let tmp = *x;
    *x = *y;
    // tmp cannot be dereferenced!
    *y = tmp;
}

// this error is normal
//  ^ consider adding a `main` function to `swap.rs
