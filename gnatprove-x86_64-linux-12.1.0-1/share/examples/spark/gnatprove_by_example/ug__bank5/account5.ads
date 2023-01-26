package Account5 with
  SPARK_Mode
is
   protected type Protected_Natural is
      procedure Incr;
      function Get return Natural;
   private
      The_Data : Natural := 0;
   end Protected_Natural;

   Num_Accounts : Protected_Natural;
   Max_Accounts : constant Natural := 100;

   task type Account_Management with
     Global  => (In_Out => Num_Accounts),
     Depends => (Account_Management => Account_Management,
                 Num_Accounts => Num_Accounts);
end Account5;
