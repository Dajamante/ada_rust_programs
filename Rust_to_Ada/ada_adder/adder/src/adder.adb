-- This shows that numbers can be passed by copy or reference
-- as long as the size is respected this is trivial
with Ada.Text_IO; use Ada.Text_IO;
package body Adder is

    function Add (X, Y : in Integer) return Integer is
        Z : Integer;
    begin
        Z := X + Y;
        return Z;
    end Add;

    procedure Increment (X : access Integer) is
    begin
        Put_Line ("Received X is: " & Integer'Image (X.all));
        X.all := X.all + 1;
    end Increment;
end Adder;
