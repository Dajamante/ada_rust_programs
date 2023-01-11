function Quadruple (I : Integer) return Integer is
    function Double (I : Integer) return Integer is

    begin
        return (I * 2);
    end Double;

    res : Integer := Double (Double (I));
begin
    -- quadruple.adb:10:05: error: cannot use call to function "Double" as a statement
    -- Double (I);
    return res;
end Quadruple;
