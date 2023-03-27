use std::alloc::{dealloc, Layout};
use std::slice;

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
        let superlongsymbol = replace();
        println!("Hello, {:?}", superlongsymbol);
        let superlongsymbol2 = slice::from_raw_parts(superlongsymbol, 5);
        // Not the nicest error handling
        // sometimes gives core dump?
        // gdb target/debug/overwrite...
        //  break *0x55921e0b2ad8
        // Cannot insert breakpoint 1.
        // Cannot access memory at address 0x55921e0b2ad8
        println!(
            "Array bytes, {:?}",
            superlongsymbol2
                .iter()
                .map(|c| *c as char)
                .into_iter()
                .collect::<String>()
        );

        // Deallocate the memory
        dealloc(
            superlongsymbol as *mut _,
            Layout::from_size_align_unchecked(5, std::mem::align_of::<u8>()),
        );
    }
}
