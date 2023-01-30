with Ada.Text_IO; use Ada.Text_IO;

procedure Months is
type Months is (January, February, March, April, May, June, July, August, September, October, November, December);
type Duration is new Integer range 1..31;
type Month_array_type is array (Months) of Duration;

Month_array: Month_array_type := (31,28,31,30,31,30,31,31,30,31,30,31);

--missing begin!
begin
for M in Months loop
-- months.adb:13:54: error: unexpected argument for "Image" attribute
-- misspelling of Months
-- " has " &Months'Image(M) & " is getting the Month!
-- the Image you need is Duration!
Put_Line(Months'Image(M) & " has" &Duration'Image(Month_array(M)) & " days");
New_Line;
end loop;
end Months;
