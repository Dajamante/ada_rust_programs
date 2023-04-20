with BBqueue;
with System.Storage_Elements; use System.Storage_Elements;
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

    --   type Offsets_Only (Size : Buffer_Size) is limited record
    -- Write : aliased Atomic_Count.Instance ;
    -- Read  : aliased Atomic_Count.Instance ;
    -- Last  : aliased Atomic_Count.Instance ;
    -- Reserve  : aliased Atomic_Count.Instance;
    -- Read_In_Progress : aliased Atomic.Flag;
    -- Write_In_Progress : aliased Atomic.Flag;
    --Granted_Write_Size : Count := 0;
    --Granted_Read_Size : Count := 0;
    type RustBBQstruct is record
        Write             : Interfaces.Unsigned_64;
        Read              : Interfaces.Unsigned_64;
        Last              : Interfaces.Unsigned_64;
        Reserve           : Interfaces.Unsigned_64;
        Read_In_Progress  : Boolean;
        Write_In_Progress : Boolean;
    end record;

    pragma Convention (Ada_Pass_By_Reference, RustReadGrant);

    procedure Read_queue (RRG : in out RustReadGrant) with
       Export, External_Name => "read_queue", SPARK_Mode => On;

end Printer;
