with Ada.Text_IO; use Ada.Text_IO;

procedure Pointer with
   SPARK_Mode
is
    -- pointer.adb:9:13: error: unconstrained subtype in component declaration
    type Pointed is record
        X : Integer         := 0;
        S : String (1 .. 5) := "Hello";
    end record;

    type PtrPointed is access Pointed;

    -- P needs to be declared as an aliased object.
    P   : Pointed    := (42, "World");
    -- Pointing to a new record created using the values of P instead.
    Ptr : PtrPointed := new Pointed'(P);

begin
    P.X := 19;
    P.S := "World";

    Ptr.X := 16;
    Ptr.S := "Bluey";

    Put_Line ("P is " & P'Img);

    Put_Line ("P alignment is " & P'Alignment'Img);
    Put_Line ("P size is " & P'Size'Img);

    Put_Line ("Ptr is " & Ptr.all'Img);

    Put_Line ("P is " & P'Img);
end Pointer;
