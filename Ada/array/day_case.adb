with Ada.Text_IO; use Ada.Text_IO;

procedure Day_case is

type Day is (Monday, Tuesday, Wednesday, Thursday, Friday);

function Get_day(D: Day := Tuesday) return String is
begin 
-- forgot to return the string and case is in the parenthesis!
return
    (case D is
        when Monday => "Monday",
        when Tuesday => "Tuesday",
        When Wednesday => "Wed",
        when Thursday..Friday => "Thu Fri");
        -- end case missing, not allowed at end of case expression
    --end case);
end Get_day;

begin
-- cannot use as a statement
-- send that or default
Put_Line(Get_day(Day'First));
end Day_case;