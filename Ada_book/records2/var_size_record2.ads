with Runtime_Length; use Runtime_Length;

package Var_size_record2 is
-- wrong, this is an array
-- type Item_array is (Positive range <>) of Integer;
    type Item_array is array (Positive range <>) of Integer;
-- should be is?
-- how to assign at runtime again
-- wrong: this is not a type but a variable at runtime
-- type Max_length := Compute_Max_Len;

-- error: statement not allowed in package spec
-- this error happens if I don't specify the type
    --Max_length : Integer := Compute_Max_Len ("9");
    -- raised STORAGE_ERROR : stack overflow or erroneous memory access when
    -- max lenght is 128 and I have Max_len : Natural := 3
    type Growable_stack (Max_len : Natural) is record
        Len            : Natural := 0;
        -- unconstrained subtype in component declaration
        Items_of_Stack : Item_array (1 .. Max_len);
    end record;
end Var_size_record2;
-- var_size_record2.ads:1: Var_Size_Record2 cannot be used as a main program
