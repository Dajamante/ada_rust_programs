extern "C" {
    fn add(x: Box<i32>, y: Box<i32>) -> i32;
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
    let x = Box::new(1);
    let y = Box::new(2);
    println!("The unsafe z is {:?}", unsafe { add(x,y) });
}
