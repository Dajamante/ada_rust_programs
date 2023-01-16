with Ada.Text_IO; use Ada.Text_IO;
-- Text_IO

procedure Integer_type is
    -- missing range
    type My_int is range -1 .. 20;

begin
-- for i in My_int
    for I in My_int loop
        -- forgot (I)!
        -- integer_type.adb:12:25: error: unrecognized attribute "My_Int"
        -- My_int'Image and not Image'My_int
        --  The Name'Attribute (optional params) notation is used for what is called an attribute in Ada.
        Put_Line (My_int'Image (I));
    end loop;
end Integer_type;
