with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Strings.UTF_Encoding; use Ada.Strings.UTF_Encoding;
with System;                   use System;
procedure Main with
   SPARK_Mode
is

    type String_to_Rust is record
        Data   : System.Address;
        Length : Integer;
    end record;

    function To_String_to_Rust (S : UTF_8_String) return String_to_Rust is
    begin
        return String_to_Rust'(Data => S'Address, Length => S'Length);
    end To_String_to_Rust;
    type SPtr is access String_to_Rust;
    S : UTF_8_String := "Hello";
    -- use all to provide read write
    -- use is not null
    procedure Overwrite (Ptr : access all String_to_Rust) with
       Import, Convention => C, Global => null;
    -- Why is the post condition not triggered
    -- Post               => Ptr.X = 16 and Ptr = "Bluey";

    S2 : String_to_Rust := To_String_to_Rust (S);
    P  : SPtr           := new String_to_Rust'(S2);

begin
    -- This is what needs to be done in Rust
    -- Ptr.X := 16;
    -- Ptr.S := "Bluey";
    Put_Line ("BEFORE OVERWRITE:");
    Put_Line ("Ptr is " & P.all'Img);

    Overwrite (P);

    Put_Line ("AFTER OVERWRITE:");
    Put_Line ("Ptr is " & P.all'Img);
end Main;
