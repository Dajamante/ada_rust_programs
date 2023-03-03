extern "C" {
    fn add(x: i32, y: i32) -> i32;
    fn increment(x: *mut i32);
}

macro_rules! increment {
    ($x:expr) => {{   
        let ptr = Box::into_raw($x);
        unsafe { increment(ptr);
            Box::from_raw(ptr) }
        
    }}
}


fn main() {
    let x = 1;
    let y = 2;
    let z = unsafe { add(x,y) };
    // Put z on the heap:
    println!("z:{:?}",z);
    let z = Box::new(z);
    println!("z: {:?}", increment!(z));
}
