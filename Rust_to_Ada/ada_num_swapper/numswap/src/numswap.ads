package Numswap is

    procedure Swap (X, Y : in out Integer) with
       Export, Convention => C, External_Name => "swap";
end Numswap;
