pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Overwriter is

    Hello : String_access := new String'("Hello");

    function Allocate_Str return String_access is
    begin
        Put_Line ("Address of Hello in SPARK: " & Hello'Img);
        return Hello;
    end Allocate_Str;

    procedure Free_str (S : in out String_access) is
        procedure internal_free is new Ada.Unchecked_Deallocation
           (Object => String, Name => String_access);
    begin
        internal_free (S);
    end Free_str;

end Overwriter;

-- Use pointers internally, nothing visible outside
-- https://people.cs.kuleuven.be/~dirk.craeynest/ada-belgium/events/16/160130-fosdem/09-ada-memory.pdf
-- must be not null!
-- https://learn.adacore.com/courses/Ada_For_The_Embedded_C_Developer/chapters/02_Perspective.html
