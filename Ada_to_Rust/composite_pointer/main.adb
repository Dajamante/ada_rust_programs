with Ada.Text_IO; use Ada.Text_IO;

procedure Main with
   SPARK_Mode
is
    type Pointed is record
        X : Integer         := 42;
        S : String (1 .. 5) := "Hello";
    end record;
    procedure Overwrite (Ptr : access Pointed) with
       Import, Convention => C, Global => null,
       -- Why is the post condition not triggered
       Post               => Ptr.X = 16 and Ptr.S = "Bluey";

    -- pointer.adb:9:13: error: unconstrained subtype in component declaration

    type PtrPointed is access all Pointed;

    -- P needs to be declared as an aliased object.
    P   : aliased Pointed;
    -- Pointing to a new record created using the values of P instead.
    -- Ptr : PtrPointed      := new Pointed'(P);
    Ptr : PtrPointed := P'Access;

    procedure Print_out (Ptr : access Pointed) is
    begin
        --Put_Line ("P is " & P'Img);
        --Put_Line ("P alignment is " & P'Alignment'Img);
        --Put_Line ("P size is " & P'Size'Img);
        Put_Line ("Ptr is " & Ptr.all'Img);
    end Print_out;

begin
    -- This is what needs to be done in Rust
    -- Ptr.X := 16;
    -- Ptr.S := "Bluey";

    Put_Line ("BEFORE OVERWRITE:");
    Print_out (Ptr);

    Overwrite (Ptr);

    Put_Line ("AFTER OVERWRITE:");
    Print_out (Ptr);

end Main;
