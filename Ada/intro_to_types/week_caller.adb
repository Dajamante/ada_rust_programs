with Ada.Text_IO; use Ada.Text_IO;
with Week; 

procedure Week_caller is
-- forgot begin!
-- week_caller.adb:7:01: error: declarations must come before "begin"
-- all inner procedures must be before begin
procedure Inner_1 is
use week;
begin
    Put_Line ("The first day is " & Mon);
end Inner_1;

-- procedure Inner_2 is
-- begin
-- this gives an error as expected
-- Put_Line ("The second day is " & Tue);
-- end Inner_2;

begin
Inner_1;

end Week_caller;