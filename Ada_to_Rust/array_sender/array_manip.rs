use std::os::raw::c_int;
// #[derive(Copy, Clone)]
// #[repr(C)]
// pub enum Day {
//     Monday,
//     Tuesday,
//     Wednesday,
//     Thursday,
//     Friday,
// }

#[no_mangle]
pub extern "C" fn add_in_array(a: *mut c_int, s: usize) -> i32 {
    unsafe {
        let a = std::slice::from_raw_parts(a, s);
        a.into_iter().sum()
    }
}

// #[no_mangle]
// pub extern "C" fn pick_in_array(x: &[Day]) -> Day {
//     let mid: usize = x.len() / 2;
//     x[mid].clone()
// }
