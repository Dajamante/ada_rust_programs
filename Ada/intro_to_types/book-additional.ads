package Book.Additional is
-- pay attention to hyphen for dependencies
-- book_additional.adb:1:18: error: file "book-additional.ads" not found
    function Extended_title return String;

    function Extended_author return String;

end Book.Additional;
