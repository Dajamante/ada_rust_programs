use std::slice;
#[repr(C)]
pub struct AdaBounds {
    // make sure the platform match
    // It is NOT wrong to use i32
    // Remember that usize makes an error!!
    first: i32,
    last: i32,
}
// whats the view
// We need to document exactly what they represent
// repr transparent trivia
#[repr(C)]
pub struct AdaString {
    data: *mut u8,
    bounds: *const AdaBounds,
}

#[no_mangle]
pub extern "C" fn change(ada_string: AdaString) {
    let data = ada_string.data;
    let bounds = ada_string.bounds;
    let _ = match safe_checks(data, bounds) {
        Ok(_) => (),
        Err(e) => println!("Error {e}"),
    };
}

fn safe_checks(data: *mut u8, bounds: *const AdaBounds) -> Result<(), &'static str> {
    if data.is_null() {
        return Err("From Rust: data is null pointer.");
    }
    if bounds.is_null() {
        return Err("From Rust: Bounds is null pointer.");
    }
    let bounds = unsafe { bounds.as_ref().ok_or_else(|| "Bounds not found")? };
    let len = (bounds.last - bounds.first + 1) as usize;
    // It assumes this is a unique pointer!!
    // very long argument to be made
    // make a rigorous argument!
    // raw_parts_mut in its documentation explains security invariant

    // Safety

    // Behavior is undefined if any of the following conditions are violated:

    // data must be valid for both reads and writes for len * mem::size_of::<T>() many bytes, and it must be properly aligned.
    // This means in particular:
    // The entire memory range of this slice must be contained within a single allocated object!
    // Slices can never span across multiple allocated objects.
    // data must be non-null and aligned even for zero-length slices.
    // One reason for this is that enum layout optimizations may rely on references (including slices of any length)
    // being aligned and non-null to distinguish them from other data.
    // You can obtain a pointer that is usable as data for zero-length slices using
    // NonNull::dangling().

    // data must point to len consecutive properly initialized values of type T.
    // The memory referenced by the returned slice must not be accessed through
    // any other pointer (not derived from the return value) for the duration of
    // lifetime 'a. Both read and write accesses are forbidden.

    // The total size len * mem::size_of::<T>() of the slice must be no larger than isize::MAX.
    // See the safety documentation of pointer::offset.

    let slice = unsafe { slice::from_raw_parts_mut(data, len) };
    //  slice::from_raw_parts_mut(data, len)
    let new_data = b"world";
    let new_len = new_data.len();

    // Without the check we get raised PROGRAM_ERROR : unhandled signal
    // thread '<unnamed>' panicked at 'range end index 5 out of range for slice of length 4', change.rs:18:5
    // if the data is longuer valgrind gives some interesting output: valgrind --tool=memcheck --leak-check=full
    if new_len <= len {
        slice[..new_len].copy_from_slice(new_data);
    } else {
        return Err("Trying to overwrite with longuer string");
    }
    Ok(())
}
