use std::convert::TryInto;

// #[repr(C)]
// pub struct AdaString {
//     length: u32,
//     data: [u8; 5], // assume max length of 5
// }
#[repr(C)]
pub struct Pointed {
    x: i32,
    // we will give away ownership
    // does it need to be a bounded string?
    s: [u8; 5],
}

// This is a way to find for the symbol
//  nm -gC --defined-only libpointer.a > log.log
#[no_mangle]
pub extern "C" fn overwrite(ptr: &mut Pointed) {
    ptr.x = 16;
    ptr.s = "Bluey".as_bytes().try_into().expect("Could not convert.");
    // ptr.s.data will yield incorrect result.
    // do we need to forget ownership here?
}
