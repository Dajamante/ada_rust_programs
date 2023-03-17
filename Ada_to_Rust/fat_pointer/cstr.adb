with Ada.Text_IO;          use Ada.Text_IO;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System;               use System;

procedure Cstr is
   procedure Change (Data : System.Address; Bounds : System.Address) with
     Import, External_Name => "change", Convention => C;

   type Bounds_Type is record
      First, Last : Integer;
   end record;

   S      : String              := "hello";
   Bounds : aliased Bounds_Type := (First => S'First, Last => S'Last);
begin
   Put_Line (S);
   Change (S'Address, Bounds'Address);
   Put_Line (S);
end Cstr;
