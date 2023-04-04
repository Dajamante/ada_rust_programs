package Overwriter is
   --type Constrained_string is new String (1 .. 5);
   type String_access is access all String;
   function Allocate_str return String_access with
     Export, External_Name => "allocate_str";
   procedure Free_str (S : in out String_access) with
     Export, External_Name => "free_str";
end Overwriter;
