with Ada.Text_IO; use Ada.Text_IO;

with System.Storage_Elements; use System.Storage_Elements;
with BBqueue;
with BBqueue.Buffers;
with System;                  use System;

package body Printer is
    procedure Print_Content (RG : BBqueue.Buffers.Read_Grant) is
        S   : constant BBqueue.Buffers.Slice_Rec := BBqueue.Buffers.Slice (RG);
        Arr : Storage_Array (1 .. S.Length) with
           Address => S.Addr;
    begin
        Put ("Print" & S.Length'Img & " bytes -> ");
        for Elt of Arr loop
            Put (Elt'Img);
        end loop;
        New_Line;
    end Print_Content;
end Printer;
