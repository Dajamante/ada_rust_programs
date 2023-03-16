#[repr(C)]
pub struct AdaString {
    data: *const u8,
    length: usize,
}

#[no_mangle]
pub extern "C" fn overwrite(ada_string: &AdaString) {
    let slice: &mut [u8] =
        unsafe { std::slice::from_raw_parts_mut(ada_string.data as *mut u8, ada_string.length) };
    //slice[..5].copy_from_slice(b"Bluey");

    let string = std::str::from_utf8(slice).unwrap();
    println!("Rust received string: {}", string);
}
