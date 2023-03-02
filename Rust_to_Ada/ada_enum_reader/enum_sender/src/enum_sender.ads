package Enum_Sender with
   SPARK_Mode => On
is
    type Dog is (SmallDog, BigDog) with
       Size => 8;

    function Send_enum return Dog with
       Export, Convention => C, External_Name => "send_enum";

end Enum_Sender;
