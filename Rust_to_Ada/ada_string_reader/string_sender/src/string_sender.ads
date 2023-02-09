package String_Sender is
    type String_5 is new String (1 .. 5);
    function Sender return String_5 with
       Export, Convention => C, External_Name => "ada_sender";

end String_Sender;
