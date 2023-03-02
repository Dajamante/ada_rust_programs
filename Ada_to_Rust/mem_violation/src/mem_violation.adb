with Ada.Text_IO; use Ada.Text_IO;

procedure Mem_Violation with
 SPARK_Mode
is
-- declaring a type of String that must have max 5 chars
  type String_5 is new String (1 .. 5);
  Hello : String_5 := "Hello";

-- in out not authorized in SPARK
  function Bloat (word : String_5) return String_5 with
   Import, Convention => C, Annotate => Terminating, Global => null;

  Res : String_5;
begin
  Res := Bloat (Hello);
  -- Gives a huge bug on Gnat
  -- Put_Line (String_5'Image (Res));
end Mem_Violation;

-- String from the perspective of rust are not easy types
-- how does ada represent characters
