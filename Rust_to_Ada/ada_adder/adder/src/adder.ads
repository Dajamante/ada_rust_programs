package Adder is

    function Add (X, Y: in Integer) return Integer with
       Export, Convention => C, SPARK_mode => On, External_Name => "add";

end Adder;
