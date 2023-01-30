with Ada.Text_IO;      use Ada.Text_IO;
with var_size_record2; use var_size_record2;

procedure Stack_caller is
    procedure Print_stack (G : Growable_stack) is
    begin
        Put ("[");
        -- prefix for range must be array, it is not G who is a range
        -- no selector "Item_array" for type "Growable_stack"
        for I in G.Items_of_Stack'Range loop
            Put (Integer'Image (G.Items_of_Stack (I)));
            -- exit when I> G.Item_array'Max;
            exit when I > G.Len;
        end loop;
        Put_Line ("]");
    end Print_stack;

-- can we have assignment inside of aggregate
-- missing ;
-- Max length  does not match any discriminant
-- Items_of_Stack does not match any discriminant, why
    G : Growable_stack :=
       (Max_len => 128, Items_of_Stack => (1, 2, 5, 7, others => <>),
        Len     => 7);
    -- If you don't specify what is what you may have "too many discriminant"
    -- G2 : Growable_stack (128, (1, 2, 5, 7, others => <>), 7);
begin
    Print_stack (G);
end Stack_caller;
