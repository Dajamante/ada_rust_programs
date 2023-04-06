with Ada.Text_IO; use Ada.Text_IO;
with System;
with System.Address_To_Access_Conversions;
with System.Storage_Elements;
with System.Address_Image;
with Ada.Unchecked_Conversion;
procedure Ruststr is
   type Rust_String is record
      ptr : System.Address;
      len : System.Storage_Elements.Storage_Count;
      cap : System.Storage_Elements.Storage_Count;

   end record;

   function Get_Rust_str return Rust_String with
     Import, External_Name => "get_rust_str";
   -- Unchecked conversion from System.Address to access to array of Character

   S : Rust_String;
   type Arr is array (Positive range <>) of Character;
   F : Arr (1 .. 5) with
     Address => S.ptr;

begin
   S := Get_Rust_str;
   Put_Line ("0x:" & System.Address_Image (S.ptr));
   Put_Line ("S.ptr'Img:" & S.ptr'Img);
   Put_Line ("S.len'Img:" & S.len'Img);
   Put_Line ("S.cap'Img:" & S.cap'Img);

   for I in 1 .. 5 loop
      Put (Character'Image (F (I)));
   end loop;
   New_Line;

end Ruststr;
