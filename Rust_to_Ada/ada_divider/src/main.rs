extern "C" {
    fn divide(x: i32, y: i32) -> i32;
}

#[macro_export]
macro_rules! to_ada_divider {
    ($x:expr, $y:expr) => {{
        let a = $x as i32;
        let b = $y as i32;
        unsafe { divide(a,b) };
    }};
}

fn main() {

    unsafe{
        let x = 1;
        let y = 0;
        let z = to_ada_divider!(x,y);
        println!("Hello, Z {:?}!", z);
    }
    
}
