with Ada.Text_IO; use Ada.Text_IO;
package body Operation is
    Last_incr : Integer;
-- is it a package still?
-- The functions have no return and therefore I have "missing return" error!
    function Increment_by
       (I : Integer := 0; Incr : Integer := 1) return Integer
    is
    --Last_incr : Integer;
    begin
-- operation.adb:4:58: error: missing "return"
-- division should be with the right sign
        if Incr /= 0 then
            Last_incr := Incr;
        end if;
-- I forgot a return here!
        return (I + Last_incr);
    end Increment_by;

    function Get_last_increment return Integer is
    begin
        return Last_incr;
    end Get_last_increment;

    -- this has no is and does not return a parameter
    function Img (I : Integer) return String
    -- missing begin!
    renames Integer'Image;

    procedure Display (I : Integer; Incr : Integer) is
    begin
        Put_Line ("The Integer and increment are" & Img (I) & Img (Incr));
    end Display;

end Operation;
