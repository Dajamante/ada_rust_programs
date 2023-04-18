pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;

package body Printer is

    procedure Fill (RRG : RustReadGrant) is
        type Arr is
           array
              (Positive range <>) of Interfaces
              .Unsigned_8;
        F : Arr (1 .. 4) with
           Address => RRG'Address;
    begin
        Put_Line ("(SPARK) Fill");
        Put_Line ("RWG'Image:" & RRG'Image);
        Put_Line
           ("System.Address_Image(RRG):" &
            System.Address_Image (RRG'Address));
        Put_Line
           ("RWG'Image innerbuf:" &
            RRG.inner_buf'Image);
        Put_Line
           ("System.Address_Image (RRG.inner_buf'Address)" &
            System.Address_Image
               (RRG.inner_buf'Address));
        Put_Line
           ("RWG'Image bbq:" & RRG.bbq'Image);
        Put_Line
           ("System.Address_Image (RRG.bbq'Address)" &
            System.Address_Image
               (RRG.bbq'Address));

        for I in 1 .. 2 loop
            Put (F (I)'Img);
        end loop;
        New_Line;

    end Fill;
end Printer;
