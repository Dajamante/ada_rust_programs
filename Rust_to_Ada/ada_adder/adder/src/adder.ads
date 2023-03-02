package Adder is

   function Add (X, Y: access Integer) return Integer with
      Export, Convention => C, SPARK_mode => On,
      Annotate => (GNATprove, Terminating),
      Post => (Add'Result = X.all + Y.all),
      External_Name => "add";

end Adder;