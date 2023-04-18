with BBqueue;
with System.Storage_Elements;
use System.Storage_Elements;
with BBqueue.Buffers;
with Interfaces;

package Printer is
    type RustReadGrant is record
        inner_buf : System.Address;
        bbq       : System.Address;
    end record;
    pragma Convention
       (Ada_Pass_By_Reference, RustReadGrant);

    type RustWriteGrant is record
        inner_buf : System.Address;
        buf_len   : Interfaces.Unsigned_64;
        bbq       : System.Address;
        to_commit : Interfaces.Unsigned_64;
    end record;
    pragma Convention
       (Ada_Pass_By_Reference, RustWriteGrant);

    procedure Fill (RRG : RustReadGrant) with
       Export, External_Name => "fill";

end Printer;
