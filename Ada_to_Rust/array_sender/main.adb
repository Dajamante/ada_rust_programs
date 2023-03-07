with Ada.Text_IO; use Ada.TEXT_IO;

procedure Main with
  SPARK_Mode
is
   --type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
   type Array_int is array (1 .. 3) of Integer;
   --type Array_days is array (1..7) of Day;
   type Access_arr_int is access Array_int;

   function Add_in_array (A : Access_arr_int; S : Integer) return Integer with
     Import, Convention => C, Global => null,
     Annotate           => (GNATprove, Terminating);
   --function Pick_in_Array (A: Array_days) return Day with
   --  Import, Convention => C, Global => null,
   --  Annotate           => (GNATprove, Terminating);

   A1   : Array_int      := (1, 2, 3);
   Acc1 : Access_arr_int := new Array_int'(A1);
   R1   : Integer;
   -- A2: Array_days := (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
   -- R2: Day;
begin
   R1 := Add_in_array (Acc1, A1'Length);
   Put_Line ("Array addition is " & Integer'Image (R1));
   pragma Assert (R1 = 6);
   -- R2 := Pick_in_Array (A2);
   -- Put_Line("Day is " & Day'Image(R2));

end Main;
