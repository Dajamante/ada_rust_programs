with Ada.Text_IO; use Ada.Text_IO;

procedure Main with
 SPARK_Mode
is
  --type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
  -- We make it explicitely equivalent
  -- int32_t type == 32 bits wide, and signed == i32
  type Array_int is array (1 .. 4) of Integer;
  --type Array_days is array (1..7) of Day;

  function Add_in_array (A : Array_int) return Integer with
   Import, Convention => C, Global => null,
   Annotate           => (GNATprove, Terminating);
  --function Pick_in_Array (A: Array_days) return Day with
  --  Import, Convention => C, Global => null,
  --  Annotate           => (GNATprove, Terminating);

  A1 : Array_int := (1, 2, 3, 4);
  R1 : Integer;
  -- A2: Array_days := (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
  -- R2: Day;
begin
  R1 := Add_in_array (A1);
  Put_Line ("Array addition is " & Integer'Image (R1));
  pragma Assert (R1 = 6);
  -- R2 := Pick_in_Array (A2);
  -- Put_Line("Day is " & Day'Image(R2));

end Main;
