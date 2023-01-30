with Ada.Text_IO; use Ada.Text_IO;

procedure Arr_slice is
Greet: String := "Hello ...";
-- statement not allowed in declarative part
-- Full_Name := "Jon Maiga";
Full_Name: String := "Jon Maiga";
begin
-- range check failed if bounds are different
Greet(7..9):= "Bob";
Put_Line(Greet);
Put_Line("Hello "& Full_Name(1..3));
end Arr_slice;