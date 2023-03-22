with Ada.Text_IO; use Ada.Text_IO;
with System;      use System;
procedure Record_access is
   --type Access_5 is access all String (1 .. 5);
   type Record_String_Int is record
      S : String (1 .. 5) := "hello";
      I : Integer         := 42;
   end record;

   procedure Change (Data : in out Record_String_Int) with
     Import, External_Name => "change";

   Rsi : Record_String_Int := (S => "world", I => 43);
   --Rsi : Record_String_Int;

begin
   Put_Line ("Rsi'Alignment" & Integer'Image (Rsi'Alignment));
   Put_Line ("Rsi'Size" & Integer'Image (Rsi'Size));
   Change (Rsi);
end Record_access;
