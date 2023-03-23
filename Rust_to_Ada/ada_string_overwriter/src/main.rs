extern "C" {
    // Segmentation fault (core dumped) if I am tryig to return
    // i32, usize, anything except a byte array
    // *mut u8 seem to return an address 0x5582489ecad8
    // Is it a heap or a stack address?
    // do rust and ada share this stack? What parts of memory do they share??
    fn replace() -> *mut u8;
}
fn main() {
    unsafe {
        let s = replace();

        println!(
            "Hello, {:?}",
            s //.map(|c| c as char).into_iter().collect::<String>()
        );
    }
}
