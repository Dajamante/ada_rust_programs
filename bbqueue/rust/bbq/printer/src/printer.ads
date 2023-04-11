with BBqueue;
with System.Storage_Elements; use System.Storage_Elements;
with BBqueue.Buffers;

package Printer is
    procedure Fill
       (WG : BBqueue.Buffers.Write_Grant; Val : Storage_Element) with
       Export, External_Name => "fill";

end Printer;
