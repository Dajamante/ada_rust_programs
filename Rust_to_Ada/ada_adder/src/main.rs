extern "C" {
    fn add(x: i32, y: i32) -> i32;
}

#[macro_export]
macro_rules! to_ada {
    ($x:expr, $y:expr) => {{
        let a = $x as i32;
        let b = $y as i32;
        let mut z = 0;
        unsafe { z = add(a,b) };
        z
    }};
}


fn main() {
    let x = 1;
    let y = 2;
    println!("The unsafe z is {:?}",to_ada!(x,y));
}
