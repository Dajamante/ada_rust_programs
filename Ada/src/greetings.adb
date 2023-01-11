with Ada.Text_IO; use Ada.Text_IO;
package body Greetings is
    procedure Hello is
    begin
        Put_Line ("Hello, World!");
    end Hello;

    procedure Goodbye is
    begin
        Put_Line ("Goodbye World!");
    end Goodbye;
end Greetings;
