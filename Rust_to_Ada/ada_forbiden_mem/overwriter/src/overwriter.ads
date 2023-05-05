package Overwriter is
  type String_Access is access String;
  function Replace return String_Access with
   Export, External_Name => "replace";

end Overwriter;
