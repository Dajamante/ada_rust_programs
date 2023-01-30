with Ada.Text_IO; use Ada.Text_IO;

package body Colors is

procedure Reverse_it(A: in out Color_array) is
    begin
    --for I in A'Range loop
    -- this is not a range! (A'First + A'Last)/2 it is a number.
    for I in A'First .. (A'First + A'Last)/2 loop
    -- for I in A'Range loop
    -- declare has begin and end
        declare
        -- what is Tmp type?
        -- no assignments
        Tmp: Color;
        Left: Color renames A(I);
        Right:Color renames A(A'First + A'Last - I);
        -- do I do end_declare?
        begin
            Put_Line(I'Img);
            Tmp := Left;
            Left := Right;
            Right:= Tmp;
        end;
    --missing end loop
    end loop;
end Reverse_it;

end Colors;