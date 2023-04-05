with Ada.Text_IO; use Ada.Text_IO;

procedure Ruststr is
   function Get_Rust_str return access String with
     Import, External_Name => "get_rust_str";
   S : access String;
begin
   S := Get_Rust_str;
   Put_Line (S'Img);
   Put_Line (S.all'Img);
   Put_Line (S'Image);
end Ruststr;
