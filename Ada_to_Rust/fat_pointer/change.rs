use std::slice;
#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[repr(C)]
pub struct AdaString {
    data: *mut u8,
    bounds: *const AdaBounds,
}

#[no_mangle]
pub extern "C" fn change(ada_string: AdaString) {
    let data = ada_string.data;
    let bounds = ada_string.bounds;
    let _ = match safe_checks(data, bounds) {
        Ok(_) => (),
        Err(e) => println!("Error {e}"),
    };
}

fn safe_checks(data: *mut u8, bounds: *const AdaBounds) -> Result<(), &'static str> {
    if data.is_null() {
        return Err("From Rust: data is null pointer.");
    }
    if bounds.is_null() {
        return Err("From Rust: Bounds is null pointer.");
    }
    let bounds = unsafe { bounds.as_ref().ok_or_else(|| "Bounds not found")? };
    let len = (bounds.last - bounds.first + 1) as usize;
    let slice = unsafe { slice::from_raw_parts_mut(data, len) };
    //  slice::from_raw_parts_mut(data, len)
    let new_data = b"world";
    let new_len = new_data.len();

    // Without the check we get raised PROGRAM_ERROR : unhandled signal
    // thread '<unnamed>' panicked at 'range end index 5 out of range for slice of length 4', change.rs:18:5
    // if the data is longuer valgrind gives some interesting output: valgrind --tool=memcheck --leak-check=full
    if new_len <= len {
        slice[..new_len].copy_from_slice(new_data);
    } else {
        return Err("Trying to overwrite with longuer string");
    }
    Ok(())
}
