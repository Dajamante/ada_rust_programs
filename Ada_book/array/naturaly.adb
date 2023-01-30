with Ada.Text_IO; use Ada.Text_IO;

procedure Naturaly is
type Integer_array is array(Natural range <>) of Integer;
-- How to make an array in a range?
My_arr: constant Integer_array:=(1,2,3);

begin
for I in My_arr'Range loop
Put(Natural'Image(My_arr(I)));
end loop;
end Naturaly;