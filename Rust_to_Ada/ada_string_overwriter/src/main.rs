use std::os::raw::c_char;
use std::slice;

#[derive(Debug)]
#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[derive(Debug)]
struct AdaStringPtr {
    ptr: *mut c_char,
    bounds: AdaBounds,
}

impl Drop for AdaStringPtr {
    fn drop(&mut self) {
        unsafe {
            free_str(self);
        }
    }
}

extern "C" {
    // check whether u8 is correct or c_char is more appropriate
    fn allocate_str() -> AdaStringPtr;
    fn free_str(ptr: *mut AdaStringPtr);
}
fn main() {
    let ada_string_ptr = unsafe { allocate_str() };
    let ptr = ada_string_ptr.ptr;
    println!("Hello pointer, {:p}", ptr);
    let mut array_slice: &mut [c_char] = unsafe { slice::from_raw_parts_mut(ptr, 5) };

    let world = b"World";
    let world2 = &world.iter().map(|a| *a as i8).collect::<Vec<i8>>();
    array_slice[..5].copy_from_slice(world2);

    drop(ada_string_ptr);
}
