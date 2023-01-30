with Ada.Text_IO; use Ada.Text_IO;
-- can be used or withed
with Measurements;


-- spec of this type does not allow a body?
-- measurements.adb:1: Measurements cannot be used as a main program
procedure Main is
-- unit is compiled with flag -gnat2022
subtype Degrees is Measurements.Degree_Celsius;
-- invalid use of subtype mark in expression or call
-- T: Degrees renames Measurements.Degrees_celsius;
T: Degrees renames Measurements.Current_temperature;
--  spec of this package does not allow a body: there is maybe no procedure to call?

--procedure Print_temp is
begin
T := 5.0;

Put_Line(Degrees'Image(T));
Put_Line(Degrees'Image(Measurements.Current_temperature));
--end Print_temp;

T := T + 2.5;

Put_Line(Degrees'Image(Measurements.Current_temperature));
end Main;
-- If I call it Main I have a linker error
-- If I call it Measurements I have:
-- measurements.adb:7:11: error: incorrect spec in file "measurements.ads" must be removed first
-- gprbuild: *** compilation phase failed