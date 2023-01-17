with Ada.Text_IO; use Ada.Text_IO;

procedure Show_days is
type Day is (Monday, Tuesday, Wednesday, Friday);

subtype Day_type is String(1..2);

type Day_type_array is array (Day) of Day_type;

-- warning: wrong length for array of type "Day_type" defined at line 6 [enabled by default] 
-- if the length is 1 or 2!
Arr: constant Day_type_array := ("Mo", "Tu", "We", "Fr");

begin
for I in Day'Range loop
-- show_days.adb:14:14: error: nonscalar 'Image is an Ada 2022 feature
    -- This will output a string ".."
    --Put_Line(Day_type'Image(Arr(I)));
    Put_Line(Arr(I));
end loop;
end Show_days;