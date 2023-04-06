#[repr(C)]
struct RustFFIString {
    ptr: *const u8,
    len: usize,
    cap: usize,
}

impl RustFFIString {
    fn from_string(s: String) -> Self {
        let raw_str = RustFFIString {
            ptr: s.as_ptr(),
            len: s.len(),
            cap: s.capacity(),
        };
        println!("The heap address of the string is {:p}", raw_str.ptr);

        std::mem::forget(s);
        raw_str
    }
}
#[no_mangle]
// 1. need to return a mutable string as a pointer
// 2. remember ada expects *mut c_char
// rust does NOT guarantee proper alignment
// tuples do!
extern "C" fn get_rust_str() -> RustFFIString {
    // s kept the lifetime tracking information
    let s = String::from("Hello");
    let raw_str = RustFFIString::from_string(s);
    raw_str
}
