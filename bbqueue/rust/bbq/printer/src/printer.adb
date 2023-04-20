pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;

package body Printer is

   function Get_BBQ_Data
     (BBQ : System.Address) return BBQueue.Offsets_Only with
     Import, Convention => C, External_Name => "send_bbq_data";

   procedure Read_queue (RRG : in out RustReadGrant) is
      type Arr is array (Positive range <>) of Interfaces.Unsigned_8;
      A : Arr (1 .. 4) with
        Address => RRG.inner_buf;

      Mirrored_bbq : aliased BBqueue.Offsets_Only (128);
   begin

      Put_Line ("(SPARK) Fill");
      Put_Line
        ("System.Address_Image (RRG.all'Address):" &
         System.Address_Image (RRG'Address));
      Put_Line ("Pointer RRG: " & System.Address_Image (RRG'Address));
      Put_Line
        ("System.Address_Image (RRG.bbq'Address), first field of ReadGrant: " &
         System.Address_Image (RRG.bbq'Address));
      -- Mirrored_bbq := Initialize_Mirrored_BBQ (Get_BBQ_Data (RRG.bbq'Address));
      -- Put_Line ("Mirrored_bbq " & Mirrored_bbq'Img);
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
