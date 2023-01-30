with Ada.Text_IO; use Ada.Text_IO;

procedure Indefinite_subtype is

-- raised CONSTRAINT_ERROR : bad input for 'Value: "uiuiu"
function Get_value return Integer is
begin
return Integer'Value(Get_Line);
end;

A: String := "Hello";
B: String(1..5);
C: String (1..Get_value);
V: Integer;
begin
-- missing ;
null;
end Indefinite_subtype;
-- How is that compiled at run time if the function is never called?