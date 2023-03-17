use std::os::raw::c_int;
use std::slice;

#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[no_mangle]
pub extern "C" fn change(data: *mut u8, bounds: *const AdaBounds) {
    let len = unsafe { (*bounds).last - (*bounds).first + 1 } as usize;
    let slice = unsafe { slice::from_raw_parts_mut(data, len) };

    let new_data = b"world";
    let new_len = new_data.len();

    if new_len <= len {
        slice[..new_len].copy_from_slice(new_data);
    }
}
