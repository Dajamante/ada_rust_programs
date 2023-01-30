with Ada.Text_IO; use Ada.Text_IO;
with Colors; use Colors;

procedure Test_colors is

My_colors : Color_array := (Blue, Orange, Cyan);

-- missing begin 
begin
--missing range in iteration over array
    Put_Line("Before");
    for C in My_colors'Range loop
        Put_Line(Color'Image(My_colors(C)));
    end loop;

    Reverse_it(My_colors);
    Put_Line("After");

    for C in My_colors'Range loop
        --Put_Line(Color'Image(My_colors(C)));
        Put_Line(My_colors(C)'Img);
    end loop;

end Test_colors;