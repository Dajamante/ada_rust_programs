with Ada.Text_IO;

procedure Main with Spark_Mode is

   procedure Add (X, Y, Z: in out Integer) with
   -- Convention == Extern in Rust
     Import, Convention => C, Global => null,
     Annotate           => (GNATprove, Terminating),
     Post               => Z = X'Old + Y'Old;

   X : Integer := 1;
   Y : Integer := 2;
   Z : Integer:= 0;
begin
   Ada.Text_IO.Put_Line ("Z =" & Z'Img);
   Add (X, Y, Z);
   pragma Assert (Z = 3);
   Ada.Text_IO.Put_Line ("Z =" & Z'Img);
end Main;
