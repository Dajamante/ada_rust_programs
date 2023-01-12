with Ada.Text_IO; use Ada.Text_IO;

procedure No_overflow is
-- slarvig läsning! They all have the same type!
    type My_int is range 0 .. 15;
    A : My_int := 12;
    B : My_int := 15;
    --subtype name cannot be used as operand
    -- A and B do not have the same type
    -- Forgot to change it to My_int, it is not an Integer
    -- a multiplication gives warning: Constraint_Error will be raised at run time [enabled by default]
    M : My_int := (A + B) / 2;

begin
    for I in 1 .. M loop
        Put_Line ("" & My_int'Image (I));
    end loop;
end No_overflow;
