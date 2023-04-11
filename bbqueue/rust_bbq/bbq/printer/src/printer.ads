with System.Storage_Elements; use System.Storage_Elements;
with BBqueue;
with BBqueue.Buffers;
with System;                  use System;

package Printer is
    procedure Print_Content (RG : BBqueue.Buffers.Read_Grant) with
       Export, External_Name => "print_content";
end Printer;
