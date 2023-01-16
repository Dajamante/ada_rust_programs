with Ada.Text_IO; use Ada.Text_IO;

-- file much match the procedure
procedure Runtime_err_bound is
type My_int is range 1..100;
type My_index is new Integer range 1..4;
--type My_array_type is array (My_index) of My_int;
type My_array_type is array (1..4) of My_int;

-- the error they are describing is not happening here!
My_array: My_array_type := (1,2,3,5);

begin
-- no range here! no I in range...
for I in 2..5 loop
-- for I in My_index 2..5 loop
-- missing argument for putline
-- raised CONSTRAINT_ERROR : runtime_err_bound.adb:8 range check failed
    Put_Line(My_int'Image(My_array(I)));
end loop;
end Runtime_err_bound;
