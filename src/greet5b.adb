with Ada.Text_IO; use Ada.Text_IO;

procedure Greet5b is
    I : Integer := 1;
begin
    --loop
    while I <= 5 loop
        Put_Line ("Greeting number " & Integer'Image (I));
        --exit when I = 5;
        I := I + 1;
    end loop;
end Greet5b;
