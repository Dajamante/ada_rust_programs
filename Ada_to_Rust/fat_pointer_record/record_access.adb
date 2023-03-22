--pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;

procedure Record_access is

   type Record_String_Int is record
      S : access String;
      I : Integer;
   end record;

   procedure Change (Data : in out Record_String_Int) with
     Import, External_Name => "change";
   --Pre => Data /= System.Null_Address and Bounds /= System.Null_Address;
   -- , Convention => C;

   Rsi : Record_String_Int := (S => new String'("hello"), I => 42);
begin
   Put_Line ("Rsi:" & Rsi'Img);
   -- is the data destroyed in between?
   Change (Rsi);
   Put_Line ("Rsi:" & Rsi.S.all'Img);
end Record_access;
