with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   type Point is record
      X, Y : Integer := 0;
   end record;
   type PtrPoint is access Point;
   P    : Point;
   --main.adb:9:36: error: if qualified expression was meant, use apostrophe
   PPtr : PtrPoint := new Point'(P);

   procedure Point_increment (ptr : PtrPoint) with
     Import, Convention => C, Global => null;
begin
   Put_Line (Point'Image (PPtr.all));
   Point_increment (PPtr);
   Put_Line (Point'Image (PPtr.all));

end Main;
