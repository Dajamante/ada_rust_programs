package Adder is

   function Add (X, Y: in Integer) return Integer with
      Export, Convention => C, SPARK_mode => On,
      Annotate => (GNATprove, Terminating),
      Post => (Add'Result = X + Y),
      External_Name => "add";

end Adder;