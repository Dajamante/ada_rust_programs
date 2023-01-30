with Ada.Text_IO; use Ada.Text_IO;
with Swap;

procedure Swap_caller is
-- read my own typos, Interger...
A: Integer := 1;
B: Integer := 2;

begin
Put_Line("A and B are" & Integer'Image(A) & Integer'Image(B));
Swap(A,B);
Put_Line("A and B are" & Integer'Image(A) & Integer'Image(B));
end Swap_caller;