use std::convert::TryFrom;
use std::slice;
#[repr(C)]
pub struct AdaBounds {
    first: i32,
    last: i32,
}

#[repr(C)]
#[derive(Debug)]
pub struct AdaString {
    inner_string: *mut u8,
    bounds: *const AdaBounds,
}

#[derive(Debug)]
#[repr(C)]
pub struct AdaRecord {
    data: AdaString,
    integer: i32,
}

#[no_mangle]
pub extern "C" fn change(ada_record: &mut AdaRecord) {
    // Ada record AdaRecord { data: AdaString { inner_string: 0x173a2a8, bounds: 0x173a2a0 }, integer: 42 }
    // 8 Bytes between both string and bounds
    println!("Ada record {:?}", ada_record);

    println!(
        "Ada bounds {:?}  {:?}",
        unsafe { (*ada_record.data.bounds).first },
        unsafe { (*ada_record.data.bounds).last }
    );
    println!("Ada record {:?}", ada_record);

    safe_change(ada_record);
}

fn safe_change(ada_record: &mut AdaRecord) -> Result<(), &'static str> {
    let string = ada_record.data.inner_string;
    let bounds = unsafe {
        (*ada_record)
            .data
            .bounds
            .as_ref()
            .ok_or_else(|| "No bounds")?
    };
    // Make all sorts of verifications for bounds
    let len = (bounds.last - bounds.first + 1) as usize;
    println!("Len {:?}", len);
    // This yields... Len 457085576552
    let info = unsafe { slice::from_raw_parts(string, len) };
    let combined_string: String = String::from_utf8(info.to_vec()).unwrap();
    println!("Ada record {:?}", combined_string);
    println!("The integer: {:?}", ada_record.integer);
    ada_record += 1;

    Ok(())
}

/*
Ada record [104, 101, 108, 108, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 0, 65, 100, 97, 32, 114, 101, 99, 111, 114, 100, 32, 91, 49, 48, 52, 44, 32, 49, 48, 49, 44, 32, 49, 48, 56, 44, 32, 49, 48, 56, 44, 32, 49, 49, 49, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 49, 55, 44, 32, 52, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 48, 44, 32, 54, 53, 44, 32, 49, 48, 48, 44, 32, 57, 55, 44, 32, 51, 50, 44, 32, 49, 49, 52, 44, 32, 49, 48, 49, 44, 32, 57, 57, 44, 32, 49, 49, 49, 44, 32, 49, 49, 52, 44, 32, 49, 48, 48, 44, 32, 51, 50, 44, 32, 57, 49, 44, 32, 52, 57, 44, 32, 52, 56, 44, 32, 53, 50, 44, 32, 52, 52, 44, 32, 51, 50, 44, 32, 52, 57, 44, 32, 52, 56, 44, 32, 52, 57, 44, 32, 52, 52, 44, 32, 51, 50, 44, 32, 52, 57, 44, 32, 52, 56, 44, 32, 53, 54, 44, 32, 52, 52, 44, 32, 51, 50, 44, 32, 52, 57, 44, 32, 52, 56, 44, 32, 53, 54, 44, 32, 52,
 */
