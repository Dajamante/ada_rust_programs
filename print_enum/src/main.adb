with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
    type TwoNum is (One, Two) with
       Size => 8;
    procedure Print_enum (one : TwoNum; two : TwoNum) with
       Import, Convention => C, Annotate => Terminating, Global => null;

begin
    Put_Line ("In Ada, " & One'Img & " and " & Two'Img);
    Print_enum (One, Two);
end Main;
