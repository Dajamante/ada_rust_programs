pragma Ada_2022;

with System;

procedure Read_From_SPARK (A : System.Address)
  with Export, External_Name => "read_from_spark";
