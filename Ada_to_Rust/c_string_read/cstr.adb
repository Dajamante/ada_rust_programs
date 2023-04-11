with Ada.Text_IO;             use Ada.Text_IO;
with System;
with Interfaces.C.Strings;    use Interfaces.C.Strings;
with System.Storage_Elements; use System.Storage_Elements;
procedure Cstr is

  function Get_c_string return System.Address with
   Import, External_Name => "get_c_string";

  S : System.Address := Get_c_string;
  type Arr is array (Positive range <>) of Character;
  F : Arr (1 .. 5) with
   Address => S;

begin

  Put_Line ("S'Img:" & S'Img);

  for I in 1 .. 5 loop
    Put (F (I)'Img);
  end loop;
  New_Line;

end Cstr;
