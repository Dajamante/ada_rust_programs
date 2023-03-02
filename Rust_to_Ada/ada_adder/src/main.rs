extern "C" {
    fn add(x: i32, y: i32) -> i32;
}

fn main() {

    unsafe{
        let x = 1;
        let y = 2;
        let z = add(x,y);
        println!("Hello, Z {:?}!", z);
    }
    
}
