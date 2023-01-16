with Ada.Text_IO; use Ada.Text_IO;

procedure Greet is
-- when do we have new?
-- new Integer?
-- looks like it always must be new
type My_Int is new Integer range 1..1000;
type Index is new Integer range 0..5;
-- no parenthesis for My_int
-- type Arr (Index) is array of My_Int;
type Arr is array (Index) of My_Int;

-- if not enough elements in index:
-- greet.adb:13:16: warning: too few elements for type "Arr" defined at line 11 [enabled by default]
My_arr: Arr := (2,5,7,8,9, 11);
V: My_Int;
begin
for I in Index loop
-- forgot to write My_arr instead of Arr
V:= My_arr(I);
-- missing ;
New_Line;
Put_Line(My_Int'Image(V));
end loop;
end Greet;