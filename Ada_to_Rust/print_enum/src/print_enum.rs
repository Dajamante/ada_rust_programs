#[derive(Debug)]
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
