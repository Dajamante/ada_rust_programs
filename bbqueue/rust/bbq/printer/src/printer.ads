with BBqueue;
with System.Storage_Elements;
use System.Storage_Elements;
with BBqueue.Buffers;
with Interfaces;

package Printer is
    type RustReadGrant is record
        bbq       : System.Address;
        inner_buf : System.Address;
        buf_len   : Interfaces.Unsigned_64;
    end record;
    pragma Convention (C, RustReadGrant);
    pragma Representation
       (RustReadGrant,
        Component_Alignment =>
           System.Storage_Elements
              .Storage_Unit);
    procedure Fill
       (RRG : access RustReadGrant) with
       Export, External_Name => "fill";

end Printer;
