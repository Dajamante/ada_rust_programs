pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;
with System;

procedure Read_From_SPARK (A : System.Address) is
   S : String(1..5) with Address => A;
begin
   Put_Line ("from SPARK: " & S'Img);
end;
