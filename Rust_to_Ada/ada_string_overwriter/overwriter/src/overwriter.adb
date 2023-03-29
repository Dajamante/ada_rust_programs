pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;
with System;      use System;
package body Overwriter is

    function Replace return access String is
        -- What happens without Convention C
        -- How does this access look like?
        -- fat pointeur pointer bounds + pointeur string
        -- first, last, chars[..]
        -- parametre pointer != object pointer
        -- convention C change quand un argument est de type pointeur
        -- param type string
        -- access va retourner les deux bornes avant!
        Hello : access String := new String'("hello");

    begin
        -- Package unchecked conversion
        Put_Line ("Address of Hello in SPARK: " & Hello'Img);
        return Hello;
    end Replace;

end Overwriter;
