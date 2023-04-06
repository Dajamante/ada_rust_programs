with Ada.Text_IO; use Ada.Text_IO;
with System;
with System.Storage_Elements;
with System.Address_Image;
procedure Ruststr is
   type Rust_String is record
      ptr      : System.Address;
      len      : System.Storage_Elements.Storage_Count;
      capacity : System.Storage_Elements.Storage_Count;

   end record;

   function Get_Rust_str return Rust_String with
     Import, External_Name => "get_rust_str";

   S : Rust_String;
begin
   S := Get_Rust_str;
   Put_Line ("0x:" & System.Address_Image (S.ptr));
   Put_Line ("Sptr.all:" & S.ptr'Img);

end Ruststr;
