with Ada.Text_IO; use Ada.Text_IO;

procedure Compute_recursive is
V: Integer; 
procedure Compute_A(V: Integer);

--procedure Show_image_renaming(S: String) is
-- no begin here
-- compute_recursive.adb:10:01: error: declarations must come before "begin"
-- did not look if it returned something here.
-- it takes an integer!
-- compute_recursive.adb:12:01: error: expected type "Standard.Integer"
function Img(I: Integer) return String
renames Integer'Image;
-- no end to function?

procedure Compute_B (V: Integer) is
-- missing then!
-- missing begin
begin
    if V > 5 then
    Put_Line ("V is " & Img(V));
    Compute_A(V - 1);
    end if;
end Compute_B;

-- forgot the argument
-- compute_recursive.adb:5:01: error: missing body for "Compute_A"
-- forgot to define procedure Compute_A!
procedure Compute_A (V: Integer) is
begin
    if V > 2 then
    Put_Line ("V is " & Img(V));
    Compute_B(V-1);
    end if;
end Compute_A;

begin
V:= 15;
    Compute_B(V);
end Compute_recursive;
