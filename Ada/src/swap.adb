procedure Swap (A, B:in out Integer) is
Tmp: Integer;

-- forgot begin!
begin
Tmp:= A;
A := B;
B := Tmp;
end Swap;
