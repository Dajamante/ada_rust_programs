procedure Hello is
    type String_A is new String (1 .. 5);
    type String_B is new String (1 .. 5);
    Hello : String_A := "Hello";
    World : String_B := "World";

begin
    Hello := World;

end Hello;
