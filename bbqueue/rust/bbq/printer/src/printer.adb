pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;
with Ada.Unchecked_Conversion;

package body Printer is

   function Get_BBQ_Data (BBQ : System.Address) return RustBBQstruct with
     Import, Convention => C, External_Name => "send_bbq_data";

   procedure Read_queue (RRG : in out RustReadGrant) is
      type Arr is array (Positive range <>) of Interfaces.Unsigned_8;
      A : Arr (1 .. 4) with
        Address => RRG.inner_buf;

      type BBBuffer_ptr is access all BBBuffer;

      -- copying byte for byte
      function To_BBBuffer_ptr is new Ada.Unchecked_Conversion
        (System.Address, BBBuffer_ptr);
      BBBPtr : BBBuffer_ptr := To_BBBuffer_ptr (RRG.bbq);

      Mirrored_bbq     : aliased BBqueue.Offsets_Only (128);
      RustOffsets_only : BBBuffer with
        Address => RRG.bbq'Address;
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
      Put_Line
        ("The pointer to BBQ: " & System.Address_Image (RRG.bbq'Address));
      Put_Line
        ("The pointer to Inner Buff: " & System.Address_Image (RRG.inner_buf));
      Put_Line ("RRG.buf_len: " & RRG.buf_len'Img);

      for I in 1 .. 4 loop
         Put (A (I)'Img);
      end loop;
      New_Line;

   end Read_queue;
end Printer;
