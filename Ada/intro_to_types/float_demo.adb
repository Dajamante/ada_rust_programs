with Ada.Text_IO; use Ada.Text_IO;

procedure Float_demo is

    type T3 is digits 3;
    type T15 is digits 15;
    -- found type universal integer if you forget the point
    -- digits value is max 6
    type T_norm is new Float digits 5 range -2.0 .. 2.0;
    type Pouces is new Float digits 4;
    type Metres is new Float digits 4;
    -- maximum is 18
    type T18 is digits 18;
    -- if I write constant Float it will not compiler
    C : constant := 1.0e-4;
    A : T3       := 1.0 + C;
    B : T15      := 1.0 + C;
    D : T_norm;
    -- type conversion. Is universal integer if I forget the point
    E : T15      := 16.0 + T15 (A);
    -- Universal integer error if no dot..
    F : Pouces   := 100.0;
    subtype Float1 is Float;
    -- why is this addition possible!
    subtype Float2 is Float range -1.0 .. 5.0;

    Now      : Float1 := 1.0;
    -- Tomorrow : Float2 := 2.0;
    -- don't put range in assignment!
    Tomorrow : Float2 := 2.0;
    -- pouces et metres must be defined before the function!
    function To_metres (P : Pouces) return Metres is
-- missing begin!
    begin
        return Metres (P) * 4.0;
    end To_metres;
begin
    Put_Line ("Adding type synonyms: " & Float'Image (Now + Tomorrow));

-- float_demo.adb:8:30: error: invalid operand types for operator "&"
    Put_Line ("T3 requires " & Integer'Image (T3'Size) & "bits");
-- float_demo.adb:10:46: error: expected type "T3" defined at line 4
    Put_Line ("T15 requires " & Integer'Image (T15'Size) & "bits");
    Put_Line ("T18 requires " & Integer'Image (T18'Size) & "bits");

-- this is really weird. One line above we have Integer'Image (T18'Size)
-- but here the expected type is T15!

    Put_Line (T3'Image (A));
    Put_Line (T15'Image (B));
    -- float_demo.adb:27:10: error: found type universal integer
    D := 1.4;
    -- The type is T_norm and not float...
    Put_Line (T_norm'Image (D));

    Put_Line ("100 pouces is so much metres " & Metres'Image (To_metres (F)));
end Float_demo;
