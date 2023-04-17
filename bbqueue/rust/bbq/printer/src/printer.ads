with BBqueue;
with System.Storage_Elements;
use System.Storage_Elements;
with BBqueue.Buffers;
with Interfaces;
--with System.Storage_Elements;
package Printer is
    -- // &[T]
    --struct Slice<T> {
    --    ptr: *const T,
    --    len: usize,
    --}
    -- assumed to be aligned, not null, and pointing to memory containing a valid value of T - for example
    type RustMutU8 is record
        len : Interfaces.Unsigned_64;
        -- ptr : System.Address;
    end record;

    type RustWriteGrant is record
        bbq : System.Address;
        buf : RustMutU8;
        --to_commit : Interfaces.Unsigned_64;
    end record;

    procedure Fill (RWG : RustWriteGrant) with
       Export, External_Name => "fill";

end Printer;
