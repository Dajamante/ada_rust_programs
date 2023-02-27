package body Numswap is

    procedure Swap (X, Y : in out Integer) is
        Temp : Integer;

    begin
        Temp := X;
        X    := Y;
        Y    := Temp;
    end Swap;

end Numswap;
