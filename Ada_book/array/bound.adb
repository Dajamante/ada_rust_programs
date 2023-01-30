with Ada.Text_IO; use Ada.Text_IO;

procedure Bound is
type My_Int is new Integer range 1..1000;
type Index is new Integer range 10..1;
type My_array_type is array (Index) of My_Int;

My_arr: My_array_type := (2,3,5,7,9);
-- V is undefined
V: My_Int;
begin
for I in Index loop
V:= My_arr(I);
Put_Line(My_Int'Image(V));
New_Line;
end loop;
end Bound;
