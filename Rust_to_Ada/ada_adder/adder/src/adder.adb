package body Adder is

function Add (X, Y: in Integer) return Integer is
    Z: Integer;
    begin
        Z := X + Y;
        return Z;
    end;
end Adder;