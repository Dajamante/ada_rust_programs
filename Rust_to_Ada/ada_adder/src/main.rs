extern "C" {
    fn add(x: &i32, y: &i32) -> i32;
}


fn main() {
    let x = 1;
    let y = 2;
    let z = unsafe { add(&x,&y) };
}
