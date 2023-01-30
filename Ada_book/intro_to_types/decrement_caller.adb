with Ada.Text_IO; use Ada.Text_IO;
with Decrement_by;

procedure Decrement_caller is
-- One can assign them after begin, but in that case they need to be defined
-- as Integer directly after procedure.
    A, B, C : Integer;
    procedure Display is
-- missing begin!
    begin
        Put_Line
           ("A:" & Integer'Image (A) & " decremented with B:" &
            Integer'Image (B) & " is C:" & Integer'Image (C));
    end Display;

begin
    A := Decrement_by;
    B := 10;
    C := Decrement_by (A, B);
-- No declaration here!
    Display;
    -- Named parameter passing:
    A := 1;
    B := 2;
    C := Decrement_by (I => B, Incr => A);
    Display;
end Decrement_caller;
