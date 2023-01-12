with Ada.Text_IO;
with Book.Additional; use Book.Additional;

procedure Main is
    package TIO renames Ada.Text_IO;
begin
    TIO.Put_Line ("The author is :" & Extended_author);
end Main;
