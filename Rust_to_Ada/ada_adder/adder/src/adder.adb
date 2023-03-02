package body Adder is

function Add (X, Y: access Integer) return Integer is
    Z: Integer;
    begin
        Z := X.all + Y.all;
        return Z;
    end;
end Adder;