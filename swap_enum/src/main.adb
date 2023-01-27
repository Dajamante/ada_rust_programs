with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
-- warning: "two_numbers" may be referenced before it has a value [enabled by default]
   -- enum Rust plus complexe == record en Ada avec des discriminants
   -- with Size => 8; nous garantit la même chose des deux còtés
   type TwoNumbers is (One, Two) with
     Size => 8;
   NumOne : TwoNumbers := One;
   NumTwo : TwoNumbers := Two;
   procedure Swap_enum (One : in out TwoNumbers; Two : in out TwoNumbers) with
     Import, Convention => C, Annotate => (GNATprove, Terminating),
     Post => NumOne = NumTwo'Old and then NumTwo = NumOne'Old, Global => null;

begin
   Put_Line
     ("One: " & TwoNumbers'Image (NumOne) & " and Two: " &
      TwoNumbers'Image (NumTwo));
   Swap_enum (NumOne, NumTwo);
   Put_Line
     ("One: " & TwoNumbers'Image (NumOne) & " and Two: " &
      TwoNumbers'Image (NumTwo));
end Main;
