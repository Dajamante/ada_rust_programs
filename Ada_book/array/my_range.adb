with Ada.Text_IO; use Ada.Text_IO;

-- gprbuild: "range.adb" was not found in the sources of any project
-- this error may mean that the word is reserved
procedure My_range is
type My_int is range 1..100;
type My_array_type is array (1..5) of My_int;
My_arr : My_array_type := (1,2,3,4,5);

begin
--for M in My_arr'Range loop
for M in My_arr'First..My_arr'Last loop
Put_Line(My_int'Image(My_arr(M)));
end loop;
end My_range;