with Ada.TEXT_IO; use Ada.TEXT_IO;
package body Adder is

function Add (X, Y: in Integer) return Integer is
    Z: Integer;
    begin
        Z := X + Y;
        return Z;
    end;

procedure Increment (X: access Integer) is
    begin
        Put_Line("Received X is: " & Integer'Image(X.all));
        X.all :=  X.all + 1;
    end;
end Adder;