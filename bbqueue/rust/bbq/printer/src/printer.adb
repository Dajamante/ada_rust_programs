pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;

package body Printer is

    procedure Fill (RRG : RustReadGrant) is

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

    end Fill;
end Printer;
