with Ada.Text_IO; use Ada.Text_IO;

procedure Modular is
-- missing mod!, this is NOT a range
    type My_mod is mod 2**5;
    A : My_mod := 17;
    B : My_mod := 18;
    M : My_mod := (A + B);

begin
    for I in 1 .. M loop
        Put_Line ("Hello World");
    end loop;
end Modular;
