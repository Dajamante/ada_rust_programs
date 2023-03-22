use std::convert::TryFrom;
use std::mem;
use std::slice;
#[repr(C)]
pub struct AdaBounds {
    first: isize,
    last: isize,
}

#[repr(C)]
pub struct AdaString {
    data: *const u8,
    bounds: *const AdaBounds,
}

#[repr(C)]
pub struct AdaRecord {
    data: AdaString,
    integer: i32,
}

#[no_mangle]
pub extern "C" fn change(ada_record: AdaRecord) {
    let data = ada_record.data.data as *mut u8;
    let integer = ada_record.integer;
    let size = mem::size_of::<AdaRecord>();
    let align = mem::align_of::<AdaRecord>();

    println!("Size: {} and align: {} of Ada record.", size * 8, align);

    let _ = match safe_checks(data, integer) {
        Ok(_) => (),
        Err(e) => println!("Error {e}"),
    };
}

fn safe_checks(data: *mut u8, integer: i32) -> Result<(), &'static str> {
    if data.is_null() {
        return Err("From Rust: data is null pointer.");
    }
    // We know the string length, let's worry about the rest later
    let slice = unsafe { slice::from_raw_parts_mut(data, 5) };

    let charvec: Vec<String> = slice
        .iter()
        .map(|c| {
            char::try_from(*c)
                .map(|c| c.to_string())
                .unwrap_or_else(|_| format!("{}", c))
        })
        .collect();
    println!("Array is : {:?}, integer {:?}", charvec, integer);
    Ok(())
}
