package Adder is

   function Add (X, Y: in Integer) return Integer with
      Export, Convention => C, SPARK_mode => On,
      Annotate => (GNATprove, Terminating),
      Post => (Add'Result = X + Y),
      External_Name => "add";
   procedure Increment (X: access Integer) with
      Export, Convention => C, SPARK_mode => On,
      Annotate => (GNATprove, Terminating),
      Post => (X.all'Old = X.all + 1),
      External_Name => "increment";

end Adder;