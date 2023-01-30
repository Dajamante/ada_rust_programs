with Ada.Text_IO;

package body Enum_hello is
   procedure Hello (One : TwoEnum; Two : TwoEnum) is
   begin
      Ada.Text_IO.Put_Line
        ("One : " & TwoEnum'Image (One) & " Two: " & TwoEnum'Image (Two));
   end Hello;

end Enum_hello;
