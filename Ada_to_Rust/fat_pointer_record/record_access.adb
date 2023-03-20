with Ada.Text_IO; use Ada.Text_IO;

procedure Record_access is

   -- record_access.adb:6:11: error: unconstrained subtype in component declaration
   type Record_string_int is record
      S : access String := new String'("hello");
      I : Integer       := 42;
   end record;

   procedure Change (S : in out Record_string_int) with
     Import, External_Name => "change";
   Rsi : Record_string_int;
begin
   Put_Line (Rsi.S.all'Img);
   Put_Line (Rsi'Img);
   Change (Rsi);
   Put_Line (Rsi.S.all'Img);
   Put_Line (Rsi'Img);
end Record_access;
