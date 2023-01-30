with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

-- main.adb:5:38: error: "is" should be ";"
-- Forgot with
    procedure Swap (X, Y : in out Integer) with
       Import, Convention => C, Global => null,
       Annotate => (GNATprove, Always_Return), Post => X'Old = Y and Y'Old = X;

-- Forgot to declare X and Y
    X : Integer := 1;
    Y : Integer := 2;

-- Integer'Image does not take an arg
    function Img (X : Integer) return String renames Integer'Image;

begin
-- main.adb:20:55: error: unexpected argument for "Image" attribute
-- Integer'Image and Img are not the same!
    Put_Line ("X:" & X'Img & " Y:" & Img (Y));
    Swap (X, Y);
    -- main.adb:18:20: error: attribute "Old" can only appear in postcondition
    pragma Assert (X = 2 and Y = 1);
    Put_Line ("X:" & Img (X) & " Y:" & Img (Y));

end Main;

-- gcc -c main.adb
-- rustc --crate-type=lib --emit=obj swap.rs
-- gnatbind main
-- gnatlink main swap.o
