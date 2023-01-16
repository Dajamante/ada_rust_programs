with Ada.Text_IO; use Ada.Text_IO;

procedure Records_ex is

-- forgot the is in type declaration
    type Months is (January, February, March);

    type Date is record
        Day   : Integer range 1 .. 31    := 1;
        Month : Months                   := January;
        Year  : Integer range 0 .. 3_000 := 2_023;
    end record;

    Today : Date;

    procedure Display_date (D : Date) is
    begin
        -- might be problem with image
        Put_Line
           ("Today is " & Integer'Image (D.Day) & "of this month " &
            Months'Image (D.Month));
    end Display_date;

begin
    Put_Line (Date'Image (Today));
    Display_date (Today);
    -- why can we reassign to Today despite it not being a in out value?
    Today.Day := 31;
    Display_date (Today);

end Records_ex;

-- records_ex.adb:7:42: error: "January" is undefined (more references follow)
-- records_ex.adb:14:15: error: nonscalar 'Image is an Ada 2022 feature
-- records_ex.adb:14:15: error: unit must be compiled with -gnat2022 switch

-- gnatmake -gnat2022 records_ex.adb
