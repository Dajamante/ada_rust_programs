with Ada.Text_IO; use Ada.Text_IO;
with System;      use System;
procedure Record_access is

   type Record_String_Int is record
      S : access String;
      I : Integer;
   end record;

   procedure Change (Data : System.Address; I : in out Integer) with
     Import, External_Name => "change";
   --Pre => Data /= System.Null_Address and Bounds /= System.Null_Address;
   -- , Convention => C;

   Rsi : Record_String_Int := (S => new String'("Hello"), I => 42);
begin
   Put_Line ("Rsi'Alignment" & Integer'Image (Rsi'Alignment));
   Put_Line ("Rsi'Size" & Integer'Image (Rsi'Size));
   Change (Rsi.S'Address, Rsi.I);
end Record_access;
