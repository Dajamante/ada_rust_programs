#[derive(Copy, Clone)]
#[repr(C)]
// Oups, totally unsafe
pub struct MyData([i32; 7]);
// pub struct MyData([i32; 4]);

impl Iterator for MyData {
    type Item = i32;
    fn next(&mut self) -> Option<Self::Item> {
        self.0.iter().copied().next()
    }
}
#[no_mangle]
pub extern "C" fn add_in_array(a: &MyData) -> i32 {
    a.0.iter().for_each(|c| println!("{c}"));
    a.0.iter().sum()
}

// #[no_mangle]
// pub extern "C" fn pick_in_array(x: &[Day]) -> Day {
//     let mid: usize = x.len() / 2;
//     x[mid].clone()
// }
