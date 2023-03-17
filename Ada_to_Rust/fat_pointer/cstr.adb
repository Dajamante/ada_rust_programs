with Ada.Text_IO;          use Ada.Text_IO;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System;               use System;

procedure Cstr with
  SPARK_Mode
is
   procedure Change (Data : System.Address; Bounds : System.Address) with
     Import, External_Name => "change",
     Pre => Data /= System.Null_Address and Bounds /= System.Null_Address;
   -- , Convention => C;

   type Bounds_Type is record
      First, Last : Integer;
   end record;

   S      : String              := "hello";
   Bounds : aliased Bounds_Type := (First => S'First, Last => S'Last);
begin
   Put_Line (S);
   -- test with System.Null_Address
   -- raised STORAGE_ERROR : stack overflow or erroneous memory access
   Change (S'Address, System.Null_Address);
   Put_Line (S);
end Cstr;
