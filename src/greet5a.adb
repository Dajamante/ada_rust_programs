with Ada.Text_IO; use Ada.Text_IO;

procedure Greet5a is
begin
    for I in 1 .. 5 loop
        Put_Line ("Hello number " & Integer'Image (I));
    end loop;
end Greet5;
