-- Test for integers.
-- Check that they are the same size in both programs.

with Ada.Text_IO;

procedure Main with
 SPARK_Mode => On
is

  function Add (X, Y : Integer) return Integer with
   -- Convention means "Extern" in Rust
   Import, Convention => C, Global => null,
   Annotate           => (GNATprove, Terminating), Post => Z = X'Old + Y'Old;

  X : Integer := 1;
  Y : Integer := 2;
  Z : Integer := 0;
begin
  Ada.Text_IO.Put_Line ("Z =" & Z'Img);
  Z := Add (X, Y);
  pragma Assert (Z = 5); -- the pragma asserts are useless
  Ada.Text_IO.Put_Line ("Z =" & Z'Img);
end Main;
