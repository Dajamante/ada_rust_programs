-- Here we use a function that returns a value.
-- List of errors: The default is in the assignment!
function Decrement_by (I : Integer := 0; Incr : Integer := 1) return Integer is
begin
    -- forgot ";"!
    -- forgot "-" decrement ...
    return (I - Incr);
end Decrement_by;
