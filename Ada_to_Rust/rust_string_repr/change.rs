use std::os::raw::c_char;

#[repr(C)]
struct RustFFIString {
    ptr: *mut c_char,
    len: usize,
    cap: usize,
}

impl RustFFIString {
    fn from_string(s: String) -> Self {
        let raw_str = RustFFIString {
            ptr: s.as_ptr() as *mut c_char,
            len: s.len(),
            cap: s.capacity(),
        };
        println!("The heap address of the string is {:p}", raw_str.ptr);

        std::mem::forget(s);
        raw_str
    }
}
impl Drop for RustFFIString {
    fn drop(&mut self) {
        println!("The string was dropped.");
    }
}
#[no_mangle]
// 1. need to return a mutable string as a pointer
// 2. remember ada expects *mut c_char
// rust does NOT guarantee proper alignment
// tuples do!
extern "C" fn get_rust_str() -> RustFFIString {
    // s kept the lifetime tracking information
    let s = String::from("hello");
    let raw_str = RustFFIString::from_string(s);
    raw_str
}
// We absolutely need the no mangle!
#[no_mangle]
extern "C" fn drop_rust_str(s: *mut RustFFIString) {
    drop(s);
}
