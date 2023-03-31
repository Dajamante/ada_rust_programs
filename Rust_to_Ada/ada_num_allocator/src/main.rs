extern "C" {
    fn allocate_integror() -> &'static mut i32;
    fn free_integror(ptr: &mut i32);
}
fn main() {
    unsafe {
        let numnum_ptr = allocate_integror();
        println!("Hello numnum, {}", *numnum_ptr);
        println!("Hello pointer, {:p}", numnum_ptr);
        *numnum_ptr = 43;
        free_integror(numnum_ptr);
    }
}
