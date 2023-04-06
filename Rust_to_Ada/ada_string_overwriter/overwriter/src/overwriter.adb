pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Overwriter is

    Hello : String_access;

    function Allocate_Str return String_access is
    begin

        Hello := new String'("hello");
        Put_Line ("Address of Hello in SPARK: " & Hello'Img);
        return Hello;
    end Allocate_Str;

    procedure Free_str (S : in out String_access) is
        procedure internal_free is new Ada.Unchecked_Deallocation
           (Object => String, Name => String_access);
    begin
        -- Put_Line ("Image for pointer " & S'Img);
        -- it is happening vvvv
        Put_Line ("Returned string SPARK S.all: " & S.all);
        Put_Line ("Returned string SPARK S'Img: " & S'Img);
        internal_free (S);
    end Free_str;

end Overwriter;
