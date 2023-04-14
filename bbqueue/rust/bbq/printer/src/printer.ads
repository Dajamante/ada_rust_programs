with BBqueue;
with System.Storage_Elements; use System.Storage_Elements;
with BBqueue.Buffers;

package Printer is
    procedure Fill with
       Export, External_Name => "fill";

end Printer;
