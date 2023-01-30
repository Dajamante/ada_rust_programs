with Operation;

procedure Operation_caller is
    use Operation;
    -- error: missing argument for parameter "I" in call to "Increment_By" declared at operation.ads:2
    -- It means that this variable is lacking a default
    I    : Integer := Increment_by;
    Incr : Integer := 1;
    -- I need a variable to reception
    -- operation_caller.adb:10:05: error: cannot use call to function "Increment_by" as a statement
    Res  : Integer;
begin
    Res := Increment_by (I, Incr);
    Display (I, Incr);
end Operation_caller;
