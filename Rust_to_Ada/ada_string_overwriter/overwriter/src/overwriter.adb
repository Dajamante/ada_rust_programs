package body Overwriter is

    function Replace return access String is
        Hello : access String := new String'("hello");
    begin
        return Hello;
    end Replace;
end Overwriter;
