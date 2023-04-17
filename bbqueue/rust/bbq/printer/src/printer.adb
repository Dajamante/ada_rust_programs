pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;

with System.Storage_Elements; use System.Storage_Elements;
with BBqueue;
with BBqueue.Buffers;
with System;                  use System;

package body Printer is

    procedure Fill (RWG : RustWriteGrant) is
    --The write grant coming from Rust is:
    --#[repr(C)]
    --#[derive(Debug, PartialEq)]
    --pub struct GrantW<'a> {
    --    pub(crate) buf: &'a mut [u8],
    --    bbq: NonNull<BBBuffer>,
    --    pub(crate) to_commit: usize,
    --}
    -- It is not commited at this stage!

    -- S   : constant BBqueue.Buffers.Slice_Rec := BBqueue.Buffers.Slice (WG);
    -- Arr : Storage_Array (1 .. S.Length) with
    --    Address => S.Addr;
    begin
        Put_Line ("(SPARK) Fill");
        Put_Line ("RWG'Img" & RWG'Img);
        --Put_Line ("Fill" & S.Length'Img & " bytes.");
        --Arr := (others => Val);
    end Fill;
end Printer;
