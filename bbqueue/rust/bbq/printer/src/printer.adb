with Ada.Text_IO; use Ada.Text_IO;

with System.Storage_Elements; use System.Storage_Elements;
with BBqueue;
with BBqueue.Buffers;
with System;                  use System;

package body Printer is
    procedure Fill is

    -- S   : constant BBqueue.Buffers.Slice_Rec := BBqueue.Buffers.Slice (WG);
    -- Arr : Storage_Array (1 .. S.Length) with
    --    Address => S.Addr;
    begin
        Put_Line ("(SPARK) Fill");
        --Put_Line ("Fill" & S.Length'Img & " bytes.");
        --Arr := (others => Val);
    end Fill;
end Printer;
