with Ada.Text_IO; use Ada.Text_IO;
-- How do I enforce the preconditions?
-- Is there a way to move the assertion here?
procedure Cstr is
   procedure Change (S : in out String) with
     Import, External_Name => "change";
   -- (1..5) is a bound!
   -- parameter
   -- return
   -- tableau (contraint, non contraint)
   -- record
   -- access
   -- fat pointer ou pointer avec first, last avant?
   -- quand c'est un param non contraint, passe les 2 pointers
   -- quand c'est un object doit retourner les 2 limites avant l'object
   S : String := "hello";
begin
   -- test with System.Null_Address
   -- raised STORAGE_ERROR : stack overflow or erroneous memory access
   -- This does not seem to work.
   Put_Line (S);
   Change (S);
   Put_Line (S);
end Cstr;
