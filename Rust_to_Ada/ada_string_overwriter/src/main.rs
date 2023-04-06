use std::ops::{Deref, DerefMut};
use std::os::raw::c_char;
use std::slice;
#[derive(Debug)]
#[repr(C)]
// using i8 causes layout problems
struct AdaBounds {
    first: i32,
    last: i32,
}
// move occurs because `*self` has type `AdaStringPtr`, which does not implement the `Copy` trait
// ^^^^ `Copy` not allowed on types with destructors
#[derive(Copy, Clone, Debug)]
#[repr(C)]
struct AdaStringPtr {
    data: *mut u8,
    bounds: *const AdaBounds,
}

// this stays in the rust world and will not adventure over the boundary
struct AdaString {
    ptr: AdaStringPtr,
}

impl AdaString {
    fn new() -> Self {
        let ptr = unsafe { allocate_str() };
        Self { ptr }
    }

    fn as_mut(&mut self) -> &mut [c_char] {
        // compiler gives wrong diagnostic here, we should keep c_char
        unsafe { slice::from_raw_parts_mut(self.ptr.data as *mut c_char, self.len()) }
    }

    fn as_ref(&self) -> &[c_char] {
        unsafe { slice::from_raw_parts(self.ptr.data as *mut c_char, self.len()) }
    }

    // self will consume!
    fn len(&self) -> usize {
        5
    }
}

impl Drop for AdaString {
    fn drop(&mut self) {
        unsafe {
            free_str(self.ptr);
        }
    }
}

impl Deref for AdaString {
    type Target = [c_char];

    fn deref(&self) -> &Self::Target {
        self.as_ref()
    }
}

impl DerefMut for AdaString {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.as_mut()
    }
}
extern "C" {
    // check whether u8 is correct or c_char is more appropriate
    fn allocate_str() -> AdaStringPtr;
    fn free_str(ptr: AdaStringPtr);
}
fn main() {
    let mut ada_str = AdaString::new();
    // let slice = ada_str.as_mut();

    // */ [] / . allowed to dereference
    // unsafety is isolated and we can rely on good rust behaviour
    ada_str[0] = b'W' as c_char;

    drop(ada_str);

    println!("The pointer was just dropped in Rust.");
}
