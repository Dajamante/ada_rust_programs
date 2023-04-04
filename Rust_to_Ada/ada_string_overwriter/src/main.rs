use std::slice;

#[derive(Debug)]
struct AdaStringPtr {
    ptr: *mut u8,
}

// OWNERSHIP BASED MODELLING
// ADDING another class adds actually a very useful trait, the possibility to call ownership and let rust manage memory for you RRELY ON OWNERSHIP

impl Drop for AdaStringPtr {
    fn drop(&mut self) {
        unsafe {
            free_str(self.ptr);
        }
    }
}

extern "C" {
    // check whether u8 is correct or c_char is more appropriate
    fn allocate_str() -> AdaStringPtr;
    fn free_str(ptr: *mut u8);
}
fn main() {
    let ada_string_ptr = unsafe { allocate_str() };
    let ptr = ada_string_ptr.ptr;
    println!("Hello pointer1, {:p}", ptr);
    let array_slice: &mut [u8] = unsafe { slice::from_raw_parts_mut(ptr, 5) };

    println!(
        "Array bytes, {:?}",
        array_slice
            .iter()
            .map(|c| *c as char)
            .into_iter()
            .collect::<String>()
    );

    let world = b"World";
    array_slice[..5].copy_from_slice(world);
    println!(
        "Printing after replacing in Rust, {:?}",
        array_slice
            .iter()
            .map(|c| *c as char)
            .into_iter()
            .collect::<String>()
    );
    // is that forcing Rust to forget about the array and let spark handle it?
    // std::mem::forget(array_slice);
    drop(ada_string_ptr);
    // the slice becomes illegal
    // println!("{:?}", ada_string_ptr);

    // if i leave this it is segfault

    // println!(
    //     "Array bytes, {:?}",
    //     array_slice
    //         .iter()
    //         .map(|c| *c as char)
    //         .into_iter()
    //         .collect::<String>()
    // );
}

/*
Address of Hello in SPARK: (access 4ce9a18)
Hello pointer1, 0x4ce9a18
Array bytes, "hello"
Printing after replacing in Rust, "World"
0x4ce9a18
==60505== Invalid read of size 1
==60505==    at 0x11397D: ada_string_overwriter::main::{{closure}} (main.rs:44)
==60505==    by 0x1116B5: core::iter::adapters::map::map_fold::{{closure}} (map.rs:84)
==60505==    by 0x110B08: core::iter::traits::iterator::Iterator::fold (iterator.rs:2438)
==60505==    by 0x111124: <core::iter::adapters::map::Map<I,F> as core::iter::traits::iterator::Iterator>::fold (map.rs:124)
 */
