-- an adb file needs a body
package Points is

type Point is record
    X,Y: Integer := 0;  
end record;

type Point_array is array (Positive range <>) of Point;

-- default value <>
A: Point := (X|Y => <>);
B: Point := (others => <>);
C: Point_array := (
                1 => (3,5),
                2 => (99,2),
                3..8 => <>);
-- no begin in ads package
end Points;