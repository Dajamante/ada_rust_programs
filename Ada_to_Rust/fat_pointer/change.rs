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

    // Without the check we get raised PROGRAM_ERROR : unhandled signal
    // thread '<unnamed>' panicked at 'range end index 5 out of range for slice of length 4', change.rs:18:5
    // if the data is longuer valgrind gives some interesting output: valgrind --tool=memcheck --leak-check=full
    if new_len <= len {
        slice[..new_len].copy_from_slice(new_data);
    }
}
