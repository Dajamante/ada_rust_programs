package Enum_hello is
   type TwoEnum is (EnumOne, EnumTwo);

   procedure Hello (One : TwoEnum; Two : TwoEnum) with
     Export, Convention => C, External_Name => "enum_hello";

end Enum_hello;
