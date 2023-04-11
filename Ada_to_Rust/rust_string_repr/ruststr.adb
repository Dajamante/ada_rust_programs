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

  procedure Drop_Rust_str (S : System.Address) with
   Import, External_Name => "drop_rust_str";

  S : Rust_String := Get_Rust_str;
  type Arr is array (Positive range <>) of Character;
  F : Arr (1 .. 5) with
   Address => S.ptr;

begin

  Put_Line ("(SPARK) 0x:" & System.Address_Image (S.ptr));
  Put_Line ("(SPARK) S.len'Img:" & S.len'Img);
  Put_Line ("(SPARK) S.cap'Img:" & S.cap'Img);

  for I in 1 .. 5 loop
    Put (F (I)'Img);
  end loop;
  New_Line;

  Drop_Rust_str (S.ptr);

end Ruststr;
