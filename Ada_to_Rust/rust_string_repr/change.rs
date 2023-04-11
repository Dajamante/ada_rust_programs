use std::os::raw::c_char;

#[derive(Debug)]
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
        println!("The allocated address by Rust is {:p}", raw_str.ptr);

        std::mem::forget(s);
        raw_str
    }
}
impl Drop for RustFFIString {
    fn drop(&mut self) {
        println!("Self in destructor {:?}", self);
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
    println!("{:?}", raw_str);
    raw_str
}
// We absolutely need the no mangle!
#[no_mangle]
extern "C" fn drop_rust_str(s: *mut RustFFIString) {
    println!("S in Rust drop function {:?}", s);
    // correct address arrives here
    drop(s);
}

/*

./ruststr
The allocated address by Rust is 0x15802a0
RustFFIString { ptr: 0x15802a0, len: 5, cap: 5 }
(SPARK) 0x:00000000015802A0
(SPARK) S.len'Img: 5
(SPARK) S.cap'Img: 5
'h''e''l''l''o'
S in Rust drop function 0x15802a0
 */
