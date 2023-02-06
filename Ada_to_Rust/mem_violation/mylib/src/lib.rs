#[derive(Clone, Debug)]
#[repr(C)]
// trying to tell the compiler what to expect
// string encoding
pub struct CString_5([u8; 5]);

#[no_mangle]
extern "C" fn bloat(word: CString_5) -> String {
    println!("S0 is : {:?}", word);

    let s1 = "world";
    let s2 = format!("{:?}{:?}", s1, word);
    println!("S2 illegally bloated?: {:?}", s2);
    s2
}
