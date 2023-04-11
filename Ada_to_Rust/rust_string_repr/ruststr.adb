with Ada.Text_IO; use Ada.Text_IO;
with System;
with Interfaces;
with System.Address_Image;
with System.Address_To_Access_Conversions;
with System.Storage_Elements;

procedure Ruststr is
   type Rust_String is record
      ptr : System.Address;
      len : Interfaces.Unsigned_64;
      cap : Interfaces.Unsigned_64;

   end record;

   function Get_Rust_str return Rust_String with
     Import, External_Name => "get_rust_str";

   function Get_c_string return System.Address with
     Import, External_Name => "get_c_string";

   procedure Drop_Rust_str (S : Rust_String) with
     Import, External_Name => "drop_rust_str";

   S : System.Address;
   type Arr is array (Positive range <>) of Character;
   F : Arr (1 .. 5) with
     Address => S;

begin
   S := Get_c_string;
   --Put_Line ("0x:" & System.Address_Image (S.ptr));
   Put_Line ("S'Img:" & S'Img);
   --Put_Line ("S.len'Img:" & S.len'Img);
   -- Put_Line ("S.cap'Img:" & S.cap'Img);

   --Put_Line ("F:" & F'Img);
   for I in 1 .. 5 loop
      Put (F (I)'Img & "space ");
   end loop;
   New_Line;

   --Drop_Rust_str (S);

end Ruststr;
