// must be declared as public
// it orders the points in memory
#[repr(C)]
pub struct Point {
    x: i32,
    y: i32,
}

#[no_mangle]
// referencing rules !! In order 1. never null
// 2. pointing to living data 3. &mut is never allowed to alias
// the rust side will be sure that there is no alias

// if not a mutable pointer, the dereferencing becomes unsafe
extern "C" fn point_increment(ptr: &mut Point) {
    ptr.x += 5;
    ptr.y += 1;
}
