package body Divider with SPARK_Mode is

function Divide (X, Y: in Integer) return Integer is
    Z: Integer;
    begin
        Z := X / Y;
        return Z;
    end;
end Divider;