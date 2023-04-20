with BBqueue;
with System.Storage_Elements;
use System.Storage_Elements;
with BBqueue.Buffers;
with Interfaces;

package Printer is

    -- What is coming from Rust:
    --    let rust_rgrant = Box::new(RustReadGrant {
    --    bbq: buf_ptr,
    --    inner: r_grant.buf.as_ptr() as *mut u8,
    --    buf_len: r_grant.buf.len(),
    --});
    type RustReadGrant is record
        bbq       : System.Address;
        inner_buf : System.Address;
        buf_len   : Interfaces.Unsigned_64;
    end record;
    pragma Convention
       (Ada_Pass_By_Reference, RustReadGrant);

    procedure Read_queue
       (RRG : in out RustReadGrant) with
       Export, External_Name => "read_queue",
       SPARK_Mode            => On;

end Printer;
