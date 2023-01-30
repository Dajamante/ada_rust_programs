with Ada.TEXT_IO; use Ada.Text_IO;
with Points;

procedure Main_points is
V: Points.Point_array := Points.C;

begin
Put_Line(V'Img);
end Main_points;