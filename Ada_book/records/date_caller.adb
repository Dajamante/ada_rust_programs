with Ada.Text_IO; use Ada.Text_IO;
-- must have use or else not visible error
with Dates; use Dates;

procedure Date_caller is
    Today : Date;
begin
    Display_date (Today);
    Increase_month (Today);
    Display_date (Today);
    Increase_month (Today);
    Display_date (Today);
    Increase_month (Today);
    Display_date (Today);
    Increase_month (Today);
    Display_date (Today);

end Date_caller;
