pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with BBqueue;
with BBqueue.Buffers;
with System;      use System;

package body Printer is

    procedure Fill (RWG : RustWriteGrant) is

    begin
        Put_Line ("(SPARK) Fill");
        Put_Line ("RWG'Address: (dec)" & RWG'Address'Image);
        Put_Line ("RWG'Img" & RWG'Img);

    end Fill;
end Printer;
