#[derive(Debug)]
//#[repr(u8)]
enum TwoNum {
    One,
    Two,
}
// the compiler warns  ^^^^^^ not FFI-safe
#[no_mangle]
extern "C" fn print_enum(one: TwoNum, two: TwoNum) {
    println!(
        "One coming from Ada is {:?} and Two coming from Ada is {:?}",
        one, two
    );
}
/*
gcc -c main.adb
rustc --crate-type=lib --emit=obj swap.rs
gnatbind main
gnatlink main swap.o
*/
