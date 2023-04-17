pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;
with System.Storage_Elements;
use System.Storage_Elements;
with BBqueue;
with BBqueue.Buffers;
with System; use System;

package body Printer is

    procedure Fill (RWG : RustWriteGrant) is

    begin
        Put_Line ("(SPARK) Fill");
        Put_Line
           ("RWG'Img: 0x" &
            System.Address_Image (RWG.bbq));
        Put_Line
           ("RWG'buffer: " &
            System.Address_Image
               (RWG.inner_buf.ptr));

    end Fill;
end Printer;
