with Ada.TEXT_IO; use Ada.Text_IO;

procedure Chars is
    type My_char is ('a', 'b','c');

    A: My_char;
    B: Character;

begin 

B := '?';
A := 'a';
--B := 65;
B := Character'Val(65);
-- A := B;

end Chars;
