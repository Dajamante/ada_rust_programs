with Ada.Text_IO; use Ada.Text_IO;
package body Divider with SPARK_Mode is

function Divide (X, Y: in Integer) return Integer is
    Z: Integer;
    begin
        Z := X / Y;
        return Z;
    exception
        when Constraint_Error =>
        Put_Line("Error: Y cannot be zero.");
        return -1;
    end;
end Divider;