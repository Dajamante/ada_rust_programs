with Runtime_Length; use Runtime_Length;

package Var_size_record is
-- not the same function name!
    Max_length : Integer := Compute_Max_Len ("3");
    type Items_type is array (Positive range <>) of Integer;

    type Growable_stack is record
        Items : Items_type (1 .. Max_length);
        Len   : Integer := Max_length;
    end record;

    G : Growable_stack;

end Var_size_record;
