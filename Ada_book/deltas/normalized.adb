-- uses : compilation unit expected
with Ada.Text_IO; use Ada.Text_IO;

procedure Normalized is
-- subtype indication expected
-- it is when I forgot the assignment
-- non static expressio used in number declaration if 2 instead of 2.0
    D : constant := 2.0**(-63);
    -- expected a real type, found universal integer
    type TQ31 is delta D range -1.0 .. 1.0 - D;

begin
    Put_Line ("D is " & D'Img);
    Put_Line ("TQ31 requires is " & TQ31'Size'Img & " bits");
    Put_Line ("TQ31 delta is " & TQ31'Delta'Img);
    Put_Line ("TQ31 first is " & TQ31'First'Img);
    Put_Line ("TQ31 last is " & TQ31'Last'Img);

end Normalized;
