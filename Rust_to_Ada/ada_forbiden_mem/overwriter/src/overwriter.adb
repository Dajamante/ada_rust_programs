pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;
with System;      use System;
package body Overwriter is

    function Replace return String_Access is
        Hello : String_Access := new String'("hello");
        --Hello : String_Access;

    begin
        --Hello := new String'("hello");
        Put_Line ("Address of Hello in SPARK: " & Hello'Img);
        return Hello;
    end Replace;

end Overwriter;
