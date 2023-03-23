with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;
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

        -- Convert the access value to an integer using unchecked conversion.
      function As_Integer is new Ada.Unchecked_Conversion (access String => Integer);
      I : Integer := As_Integer (Hello);

     
   begin
      -- Package unchecked conversion
      Put_Line ("Address of Hello: " & Integer'Image (System'To_Address (Hello)));
      return Hello;
   end Replace;

end Overwriter;