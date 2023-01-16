package Dates is

-- missing new
    type Day is new Integer range 1 .. 31;
    type Month is (January, February, March);
    type Year is new Integer range 0 .. 3_000;

    type Date is record
        D : Day   := 1;
        M : Month := January;
        Y : Year  := 2_022;
-- not end Date but end Record
    end record;

-- Want to see what happens without in out!
-- Forgot to change some date to some month
    procedure Increase_month (Some_date : in out Date);

    procedure Display_date (Some_date : Date);

end Dates;
