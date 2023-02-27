with Ada.Text_IO; use Ada.Text_IO;
with Points;

procedure Main_points with
   SPARK_Mode
is
    V : Points.Point_array := Points.C;

begin
    Put_Line (V'Img);
end Main_points;
