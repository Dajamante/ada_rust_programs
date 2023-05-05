use std::os::raw::c_char;
use std::slice;
#[no_mangle]
extern "C" {
    // check whether u8 is correct or c_char is more appropriate
    fn replace() -> *mut c_char;
}
fn main() {
    let mut ada_str = unsafe { replace() };
    println!("Hello pointer, {:p}", ada_str);
    // let ada_str = unsafe { slice::from_raw_parts(ada_str, 5) };
    // println!(
    //     "Array bytes, {:?}",
    //     ada_str
    //         .iter()
    //         .map(|c| *c as u8 as char)
    //         .into_iter()
    //         .collect::<String>()
    // );
}
