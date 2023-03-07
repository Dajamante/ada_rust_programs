#[no_mangle]
extern "C" {
    fn add(x: i32, y: i32) -> i32;
    fn increment(x: &mut i32);
}

macro_rules! increment {
    ($x:expr) => {{
        unsafe {
            increment($x);
            let tmp = *$x;
            tmp
        }
    }};
}

fn main() {
    // Need to add this to main to generate the graph
    // LD_LIBRARY_PATH=adder/lib cargo rustc -- -Z unpretty=mir-cfg > output-graph.dot
    let x = 1;
    let y = 2;
    let mut z = unsafe { add(x, y) };
    increment!(&mut z);
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
