with Ada.Text_IO; use Ada.Text_IO;

procedure Greeting is
-- no range, just parenthesis!
-- missing range keyword
-- greeting.adb:6:11: error: incorrect constraint for this kind of type
-- A: String (1..12) := "Hello, World";

A: String := "Hello";
begin 
for I in reverse A'Range loop
-- greeting.adb:8:01: error: missing argument for parameter "Item" in call to "Put_Line" declared at a-textio.ads:496
-- Put_Line wants a String but not Put!
Put(A(I));
end loop;
end Greeting;