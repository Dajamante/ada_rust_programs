package body Book.Additional is

    function Extended_title return String is
-- forgot begin again
    begin
        return "From extended" & Title;
    end Extended_title;
-- this gives an error as expected
    --function Extended_author return String is
    --begin
    --    return "The author is" & Author;
    --end Extended_author;

    function Extended_author return String is
    begin
        return "From extended " & Get_author;
    end Extended_author;

end Book.Additional;
