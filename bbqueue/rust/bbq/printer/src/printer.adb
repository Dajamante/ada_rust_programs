pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;
with Ada.Unchecked_Conversion;

package body Printer is

  --function Convert_RustBBQ_To_Offsets_Only
  -- (Rust_BBQ : BBBuffer) return access BBqueue.Offsets_Only
  --is
  --  Result : BBqueue.Offsets_Only (Size => 128);
  --begin
  --  Result.Write              := Atomic_Count.Init (Rust_BBQ.Write);
  --  Result.Read               := Atomic_Count.Init (Rust_BBQ.Read);
  --  Result.Last               := Atomic_Count.Init (Rust_BBQ.Last);
  --  Result.Reserve            := Atomic_Count.Init (Rust_BBQ.Reserve);
  --  Result.Read_In_Progress   := Atomic.Init (Rust_BBQ.Read_In_Progress);
  --  Result.Write_In_Progress  := Atomic.Init (Rust_BBQ.Write_In_Progress);
  --  Result.Granted_Write_Size := 0;
  --  Result.Granted_Read_Size  := 0;
  --  return Result;

  --end Convert_RustBBQ_To_Offsets_Only;

  function Get_BBQ_Data (BBQ : System.Address) return BBqueue.BBBuffer with
   Import, Convention => C, External_Name => "send_bbq_data";

  procedure Read_queue (RRG : in out RustReadGrant) is
    type Arr is array (Positive range <>) of Interfaces.Unsigned_8;
    A : Arr (1 .. 4) with
     Address => RRG.inner_buf;

    RustOffsets_only : BBqueue.BBBuffer with
     Address => RRG.bbq'Address;
    Mirrored_bbq     : access BBqueue.Offsets_Only :=
     BBqueue.Convert_RustBBQ (RustOffsets_only);
  begin

    Put_Line ("SPARK function.");
    Put_Line
     ("System.Address_Image (RRG.all'Address):" &
      System.Address_Image (RRG'Address));
    Put_Line ("Pointer RRG: " & System.Address_Image (RRG'Address));
    Put_Line
     ("System.Address_Image (RRG.bbq'Address), first field of ReadGrant: " &
      System.Address_Image (RRG.bbq'Address));

    Put_Line (" Rust offsets_only" & RustOffsets_only'Img);

    Put_Line
     ("System.Address_Image (RRG.bbq), the pointer to BBQ " &
      System.Address_Image (RRG.bbq));
    Put_Line
     ("System.Address_Image (RRG.inner_buf'Address)" &
      System.Address_Image (RRG.inner_buf'Address));

    Put_Line
     ("System.Address_Image (RRG.buf_len'Address)" &
      System.Address_Image (RRG.buf_len'Address));
    Put_Line ("RRG.buf_len'Img" & RRG.buf_len'Img);
    Put_Line ("The pointer to BBQ: " & System.Address_Image (RRG.bbq'Address));
    Put_Line
     ("The pointer to Inner Buff: " & System.Address_Image (RRG.inner_buf));
    Put_Line ("RRG.buf_len: " & RRG.buf_len'Img);

    for I in 1 .. 4 loop
      Put (A (I)'Img);
    end loop;
    New_Line;

  end Read_queue;
end Printer;
