with Ada.Text_IO; use Ada.Text_IO;

procedure Lib_Addition is
    X : Integer;
    Y : Integer;
begin
    X := 4;
    Y := 3;
    Put_Line
       ("The initial value of X is" & Integer'Image (X) &
        " and the initial value of Y is" & Integer'Image (Y));
    Put_Line ("The sum is :" & Integer'Image (X + Y));
end Lib_Addition;
