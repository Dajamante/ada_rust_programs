package Dates is

    type Months is (January, February, March);

    type Date is record
        Day: Integer range 1..31 := 1;
        Month: Months := January;
        Year : Integer range 1..3000 := 2022;
    end record;
-- forgot end date
end Dates;