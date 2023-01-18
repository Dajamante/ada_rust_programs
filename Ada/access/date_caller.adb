with Ada.TEXT_IO; use Ada.TEXT_IO;
with Access_type; use Access_type;

procedure Date_caller is
-- subtype mark required in this context! It should be an assignment here, and not a "":"!
    New_access : Date_access := My_access;
    New_access_2 : String_access := My_second_access;
    begin
    -- prints (access dc72a0)
    Put_Line(New_access'Img);

    Put_Line(New_access.all'Img);
    
    -- automatic dereferencing?
    --Put_Line(New_access_2(1..2).all'Img);
    Put_Line(New_access_2'Img);
    Put_Line(New_access_2(1..4));
end Date_caller;
