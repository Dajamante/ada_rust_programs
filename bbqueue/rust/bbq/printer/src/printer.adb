pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;

package body Printer is

    procedure Fill (RRG : access RustReadGrant)
    is
        type Arr is
           array
              (Positive range <>) of Interfaces
              .Unsigned_8;
        F : Arr (1 .. 4) with
           Address => RRG.inner_buf;
    begin
        Put_Line ("(SPARK) Fill");
        Put_Line
           ("System.Address_Image (RRG'Address):" &
            System.Address_Image
               (RRG.all'Address));
        Put_Line
           ("System.Address_Image (RRG.inner_buf'Address)" &
            System.Address_Image
               (RRG.inner_buf'Address));
        Put_Line
           ("RRG.buf_len'Img" &
            RRG.buf_len'Img);
        Put_Line
           ("System.Address_Image (RRG.bbq'Address)" &
            System.Address_Image
               (RRG.bbq'Address));

        Put_Line
           ("RRG.bbq: " &
            System.Address_Image (RRG.bbq));
        Put_Line
           ("RRG.inner_buf: " &
            System.Address_Image
               (RRG.inner_buf));
        Put_Line
           ("RRG.buf_len: " & RRG.buf_len'Img);

        for I in 1 .. 4 loop
            Put (F (I)'Img);
        end loop;
        New_Line;

    end Fill;
end Printer;
