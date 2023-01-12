with Ada.Text_IO; use Ada.Text_IO;

procedure Overflow is
    A : Integer := Integer'Last;

begin
-- putline needs standard string
-- cannot concatenate with Integer'Image
-- as expected overflow at runtime
    Put_Line ("" & Integer'Image (A + 5));
end Overflow;
