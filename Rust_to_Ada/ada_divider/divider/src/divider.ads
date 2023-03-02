package Divider with SPARK_mode is

   function Divide (X, Y: in Integer) return Integer with
      Export, Convention => C, SPARK_mode => On,
      Annotate => (GNATprove, Terminating),
      Pre => Y > 0 and then Y /= 0 and then X / Y <= 2**31-1,
      -- divider.adb:6:16: medium: overflow check might fail, cannot prove upper bound for X / Y Z := X / Y;
      External_Name => "divide";

end Divider;