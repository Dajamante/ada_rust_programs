#[repr(C)]
pub struct AdaRecord {
    data: *mut u8,
    integer: i32,
}

#[no_mangle]
pub extern "C" fn change(ada_record: AdaRecord) {
    let data = ada_record.data;
    let integer = ada_record.integer;
    let slice = unsafe { std::slice::from_raw_parts_mut(data, 5) };

    println!("In Rust: slice: {:?}, integer {:?}", slice, integer);
    // What happens to the data when printed???

    // (S => "hello",
    // I =>  42)
    // Data: 0x6f6c6c6568, integer 42

    // (S => "",
    // I =>  0)
}
