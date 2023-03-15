with Ada.Text_IO; use Ada.Text_IO;

procedure Main with
   SPARK_Mode
is
    -- This type is the same but has no bounded string.
    type Pointed is record
        X : Integer := 42;
        S : access String;
    end record;

    procedure Overwrite (Ptr : access Pointed) with
       Import, Convention => C, Global => null,
       -- Why is the post condition not triggered
       Post               => Ptr.X = 16 and Ptr.S.all = "Bluey";

    -- pointer.adb:9:13: error: unconstrained subtype in component declaration

    type PtrPointed is access all Pointed;

    -- P needs to be declared as an aliased object.
    P   : aliased Pointed;
    -- Pointing to a new record created using the values of P instead.
    -- Ptr : PtrPointed      := new Pointed'(P);
    Ptr : PtrPointed := P'Access;

begin
    -- This is what needs to be done in Rust
    -- Ptr.X := 16;
    -- Ptr.S := "Bluey";
    Ptr.S := new String'("Hello");
    Put_Line ("BEFORE OVERWRITE:");
    Put_Line ("Ptr is " & Ptr.all'Img);

    Overwrite (Ptr);

    Put_Line ("AFTER OVERWRITE:");
    Put_Line ("Ptr is " & Ptr.all'Img);
end Main;
