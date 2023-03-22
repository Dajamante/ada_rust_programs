package body Overwriter is

    function Replace return String is
        Hello : String (1 .. 5) := "hello";
    begin
        return Hello;
    end Replace;
end Overwriter;
