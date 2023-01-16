with Ada.Text_IO; use Ada.Text_IO;

package body Dates is

-- Want to see what happens without in out!
procedure Increase_month(Some_date: in out Date) is
M renames Some_date.M;
Y renames Some_date.Y;
begin
if M = March then
-- dates.adb:11:01: error: left hand side of assignment must be a variable
-- well this rename is quite useless!
Some_date.M := January;
Some_date.Y := Y +1;
-- missing endif
else
Some_date.M := Month'Succ(M);
end if;


end Increase_month;

procedure Display_date(Some_date: Date) is
M renames Some_date.M;
Y renames Some_date.Y;
begin
Put_Line("Date is " & Month'Image(M));
end Display_date;

end Dates;