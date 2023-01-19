with Ada.Text_IO;      use Ada.Text_IO;
with Var_size_record2; use Var_size_record2;

procedure Main is
--  argument of type conversion must be single expression
-- S : Growable_stack (9) := Item_array (1, 2, 3);
    Arr : Item_array     := Item_array'(1, 2, 3);
    -- this will be a constraint error as 3 elements are enable by default
    -- S   : Growable_stack := (N => 5, Len => 9, Items_of_Stack => Arr);
    -- setting it to default gives:
    -- var_size_record2.ads:15:10: warning: creation of "Growable_stack" object may raise Storage_Error [enabled by default]
    S   : Growable_stack := (N => <>, Len => 9, Items_of_Stack => Arr);
-- invalid constraint: type has no discriminant
begin
    Put_Line (Growable_stack'Image (S));
end Main;
