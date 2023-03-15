#[repr(C)]
pub struct Pointed<'a> {
    x: i32,
    // we will give away ownership
    // does it need to be a bounded string?
    s: &'a str,
}

#[no_mangle]
pub extern "C" fn overwrite(ptr: &mut Pointed) {
    ptr.x = 16;
    ptr.s = "Bluey";

    // do we need to forget ownership here?
}
