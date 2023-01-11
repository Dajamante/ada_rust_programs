with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Adding is
    N1 : Integer;
    N2 : Integer;
begin
    Put ("Enter N1: ");
    Get (N1);
    Put ("Enter N2: ");
    Get (N2);

    if N1 >= 0 and N2 >= 0 then
        Put (N1 + N2);
        Put (" is the result!");
    elsif N1 < 0 and N2 < 0 then
        Put_Line ("Both numbers are negative. ");
    elsif N2 < 0 then
        Put_Line ("N2 is negative. ");
    elsif N1 < 0 then
        Put_Line ("N1 is negative");
    else
        Put_Line ("Something else happened. ");
    end if;
end Adding;
