#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[repr(C)]
pub struct AdaString {
    // internal memory allocation
    data: Box<[u8]>,
    bounds: AdaBounds,
}

impl AdaString {
    fn new(data: Box<[u8]>, bounds: AdaBounds) -> Self {
        Self { data, bounds }
    }
}

impl Drop for AdaString {
    fn drop(&mut self) {
        println!("The AdaString was dropped");
    }
}

#[no_mangle]
pub extern "C" fn get_rust_str() -> *mut AdaString {
    //  pub extern "C" fn get_rust_str() -> AdaString {
    //                                     ^^^^^^^^^ not FFI-safe
    let bounds = AdaBounds { first: 1, last: 5 };
    let hello = Box::new(*b"Hello");
    let ada_str = AdaString::new(hello, bounds);

    // no more warnings with boxing the structure
    Box::into_raw(Box::new(ada_str))
}
