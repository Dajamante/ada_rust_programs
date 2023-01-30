with Ada.TEXT_IO; use Ada.Text_IO;
with Convert;

procedure Convertor_caller is
    A: String := "hello";
    B: Integer;
    -- how to make a new line??
    C: Character := Character'Val(10);
    D: Integer;

    begin
        B := Convert.Convertor(A);
        Put_Line(B'Img);
        Put_Line(C'Img);
        D := Convert.Convertor(C);
        Put_Line(D'Img);
    end Convertor_caller;


