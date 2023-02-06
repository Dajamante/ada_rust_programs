#[allow(dead_code)]
#[derive(Debug)]
#[repr(C)]
enum TwoNum {
    One,
    Two,
}
// values are currently on the stack
// if a function is not inlined
// check if no inlining
// inlining is done before link
// pointers are aligned on words
// we are checking that it is picking at the right place
// inline: why we suspect it cuold be a problem
// put a pragma on the callee function

#[no_mangle]
extern "C" fn print_enum(one: TwoNum, two: TwoNum) {
    println!("One is: {:?} and Two is : {:?}", one, two);
}

// rustc --crate-type=lib --emit=obj lib.rs -o print_enum.o
