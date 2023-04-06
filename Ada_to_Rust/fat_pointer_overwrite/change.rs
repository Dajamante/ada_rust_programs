#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[repr(C)]
// Internal memory repr hidden for the user
pub struct AdaStringPtr {
    // internal memory allocation that must follow Ada convention
    data: *mut ptr,
    bounds: *const AdaBounds,
}

impl AdaString {
    fn new() -> Self {
        // 1. make bounds
        let bounds = AdaBounds { first: 1, last: 5 };
        // 2. make a pointer to a string
        // 3. return a self with bounds and internal pointer
        Self {}
    }
}

// The drop must be done for the user object that has API
impl Drop for AdaString {
    fn drop(&mut self) {
        println!("The AdaString was dropped");
    }
}

#[no_mangle]
pub extern "C" fn get_rust_str() -> *mut AdaString {
    //  pub extern "C" fn get_rust_str() -> AdaString {
    //                                     ^^^^^^^^^ not FFI-safe
    let hello = Box::new(*b"Hello");
    let ada_str = AdaString::new(hello, bounds);

    // no more warnings with boxing the structure
    Box::into_raw(Box::new(ada_str))
}
