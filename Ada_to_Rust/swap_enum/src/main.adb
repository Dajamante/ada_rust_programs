with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
-- warning: "two_numbers" may be referenced before it has a value [enabled by default]
   -- enum Rust plus complexe == record en Ada avec des discriminants
   -- with Size => 8; nous garantit la même chose des deux còtés
   -- weirdly this works when we change the size in Ada
   type TwoNumbers is (One, Two, Three) with
     Size => 8;
   NumOne   : TwoNumbers := One;
   NumTwo   : TwoNumbers := Two;
   NumThree : TwoNumbers := Three;
   -- le link ne vérifie rien
   -- chaque cote prend juste un nom de fonction
   -- c'est pour ca que l'on génère les bindings
   procedure Swap_enum
     (One   : in out TwoNumbers; Two : in out TwoNumbers;
      Three : in out TwoNumbers) with
     Import, Convention => C, Annotate => (GNATprove, Terminating),
     Post               =>
      NumOne = NumThree'Old and then NumTwo = NumOne'Old
      and then NumThree = NumTwo'Old,
     Global             => null;

begin
   Put_Line
     ("One: " & TwoNumbers'Image (NumOne) & " and Two: " &
      TwoNumbers'Image (NumTwo) & " and Three: " &
      TwoNumbers'Image (NumThree));
   Swap_enum (NumOne, NumTwo, NumThree);
   Put_Line
     ("One: " & TwoNumbers'Image (NumOne) & " and Two: " &
      TwoNumbers'Image (NumTwo) & " and Three: " &
      TwoNumbers'Image (NumThree));
end Main;
