with Ada.Text_IO; use Ada.Text_IO;
with Quadruple;

procedure Quadruple_caller is
-- error res is undefined if not left in the "declaration region"
    I, res : Integer;
begin
    I   := 3;
    res := Quadruple (I);

    Put_Line ("The res is" & Integer'Image (res));

end Quadruple_caller;
