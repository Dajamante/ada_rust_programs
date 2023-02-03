with Ada.Text_IO; use Ada.Text_IO;

procedure Panicking with
 SPARK_Mode
is
-- declaring a type of String that must have max 5 chars

-- in out not authorized in SPARK
  procedure Panicking with
   Import, Convention => C, Annotate => Terminating, Global => null;
begin
  Panicking;
end Panicking;
