procedure Main is
    type TwoNum is (Enum11One, Enum22Two) with
       Size => 8;
    procedure Print_enum (one : TwoNum; two : TwoNum) with
       Import, Convention => C, Annotate => Terminating, Global => null;

begin
    Print_enum (Enum11One, Enum22Two);
end Main;
