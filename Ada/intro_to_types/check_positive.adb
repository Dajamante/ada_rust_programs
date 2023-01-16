with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Check_positive is
    N : Integer;
begin
    Put ("Write a number: ");
    Get (N);
    Put (N);

    declare
        S : String :=
           (if N > 0 then " is a positive number."
            elsif N < 0 then " is a negative number." else " is zero.");
    begin
        Put_Line (S);
    end;
end Check_positive;
