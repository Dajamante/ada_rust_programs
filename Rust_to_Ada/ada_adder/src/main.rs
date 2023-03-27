extern "C" {
    fn add(x: i32, y: i32) -> i32;
    fn increment(x: *mut i32);
}

// macro_rules! increment {
//     ($x:expr) => {{
//         unsafe {
//             increment($x);
//             let tmp = *$x;
//             tmp
//         }
//     }};
// }

// This is a voluntary memory leak, returning a raw pointer instead of
// Box operation.
macro_rules! increment {
    ($x:expr) => {{
        unsafe {
            let ptr = Box::into_raw($x);
            increment(ptr);
            ptr
        }
    }};
}
fn main() {
    // Need to add this to main to generate the graph
    // LD_LIBRARY_PATH=adder/lib cargo rustc -- -Z unpretty=mir-cfg > output-graph.dot
    // This command shows which variable causes the leak
    // LD_LIBRARY_PATH=adder/lib valgrind --tool=memcheck --leak-check=full target/debug/ada_adder
    // LD_LIBRARY_PATH=adder/lib cargo miri run -- -Zmiri-disable-isolation
    let x = 1;
    let y = 2;
    let z = unsafe { add(x, y) };
    let z = Box::new(z);

    let z = increment!(z);
    // RUSTFLAGS="-g" LD_LIBRARY_PATH=adder/lib cargo run
    // LD_LIBRARY_PATH=adder/lib valgrind --tool=memcheck target/debug/ada_adder
    // Will find a dataleak of 4 bytes
    println!("Z is: {:?}", unsafe { *z });
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        let x = 1;
        let y = 2;
        let z = unsafe { add(x, y) };
        assert_eq!(z, 3);
    }

    #[test]
    fn test_incr() {
        let mut z = 3;
        // let z = Box::new(z);
        let z = increment!(&mut z);
        assert_eq!(z, 4);
    }
}
