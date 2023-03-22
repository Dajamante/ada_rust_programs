with Ada.Text_IO; use Ada.Text_IO;

procedure Access_sizes is

    S : access String    := new String'("Hello");
    I : access Integer   := new Integer'(42);
    C : access Character := new Character'('c');

begin

    Put_Line (Integer'Image (S'Size));
    Put_Line (Integer'Image (I'Size));
    Put_Line (Integer'Image (C'Size));

end Access_sizes;
