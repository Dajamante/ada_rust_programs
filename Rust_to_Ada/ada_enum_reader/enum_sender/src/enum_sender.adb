package body Enum_Sender with
   SPARK_Mode => On
is

    D : Dog;

    function Send_enum return Dog is
    begin
        return D;
    end Send_enum;

end Enum_Sender;
