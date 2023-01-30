project Ada_Addition
is

    for Source_Dirs use ("src");
    for Object_Dir use "obj";
    for Create_Missing_Dirs use "True";
    for Library_Name use "ada_addition";
    for Library_Kind use "dynamic";
    for Library_Standalone use "encapsulated";
    for Library_Interface use ("ada_addition");
    for Library_Dir use "lib";

end Ada_Addition;

package Ada_Addition is
    procedure Addition with
        Export,
        Convention => C,
        External_Name => "ada_addition";
end Ada_Addition;

with Ada.Text_IO; use Ada.Text_IO;

package body Ada_Addition is
procedure Addition is
begin
    X: Integer := 4;
    Y: Integer := 3;
    Put_Line ("The sum is :" & Integer'Image (X + Y));
end Addition;
end Ada_Addition;;
