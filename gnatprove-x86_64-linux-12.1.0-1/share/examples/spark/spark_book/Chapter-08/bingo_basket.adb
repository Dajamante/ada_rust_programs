with Bingo_Basket.Random;
package body Bingo_Basket with SPARK_Mode => On is

   type Number_Array is array (Callable_Number) of Callable_Number;
   The_Basket : Number_Array; -- A sequence of numbers in the basket
   The_Count  : Bingo_Number; -- The count of numbers in the basket

   procedure Swap (X : in out Callable_Number;
                   Y : in out Callable_Number) is
      Temp : Callable_Number;
   begin
      Temp := X;  X := Y;  Y := Temp;
   end Swap;

   function Empty return Boolean is (The_Count = 0);

   procedure Load is
      Random_Index : Callable_Number;
   begin
      -- Put all numbers into the basket (in order)
      for Number in Callable_Number loop
         The_Basket (Number) := Number;
      end loop;
      -- Randomize the array of numbers
      for Index in Callable_Number loop
         Random_Index := Bingo_Basket.Random.Random_Number;
         Swap (X => The_Basket (Index),
               Y => The_Basket (Random_Index));
      end loop;
      The_Count := Callable_Number'Last;  -- all numbers now in the basket
   end Load;

   procedure Draw (Letter : out Bingo_Letter;
                   Number : out Callable_Number) is
   begin
      Number    := The_Basket (The_Count);
      The_Count := The_Count - 1;

      -- Determine the letter using the subtypes in Bingo_Definitions
      case Number is
         when B_Range =>  Letter := B;
         when I_Range =>  Letter := I;
         when N_Range =>  Letter := N;
         when G_Range =>  Letter := G;
         when O_Range =>  Letter := O;
      end case;
   end Draw;
end Bingo_Basket;
