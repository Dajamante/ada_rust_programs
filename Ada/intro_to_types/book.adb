package body Book is
--  = should be :=
    Author : String := "I am the invisible author";

    function Get_author return String is
    begin
        return Author;
    end Get_author;

    -- forgot return
    function Get_title return String is
    begin
        return Title;
    end Get_title;

end Book;
