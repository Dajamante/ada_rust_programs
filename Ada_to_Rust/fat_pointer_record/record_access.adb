with Ada.Text_IO; use Ada.Text_IO;
with System;      use System;
procedure Record_access is
   type Access_5 is access all String (1 .. 5);
   type Record_String_Int is record
      S : Access_5;
      I : Integer;
   end record;

   procedure Change (Data : in out Record_String_Int) with
     Import, External_Name => "change";

   S   : aliased String (1 .. 5) := "Hello";
   Rsi : Record_String_Int       := (S => S'Access, I => 42);

begin
   Put_Line ("Rsi'Alignment" & Integer'Image (Rsi'Alignment));
   Put_Line ("Rsi'Size" & Integer'Image (Rsi'Size));
   Change (Rsi);
end Record_access;
