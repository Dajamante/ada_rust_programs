extern "C" {
    fn add(x: *mut i32, y: *mut i32) -> i32;
}


fn main() {
    let x = Box::new(1);
    let y = Box::new(6);
    let x_ptr = Box::into_raw(x);
    let y_ptr = Box::into_raw(y);
    println!("The unsafe z is {:?}", unsafe { add(x_ptr,y_ptr) });
    
}
