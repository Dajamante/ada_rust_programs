-- What do we have this for!
-- Phase 1 of 2: generation of Global contracts ...
-- Phase 2 of 2: flow analysis and proof ...
--  $ gnatprove -P  adder.gpr
-- adder.ads:10:55: medium: pointer dereference check might fail
--   10 |     Annotate => (GNATprove, Terminating), Post => (X.all'Old = X.all + 1),
-- warning: no bodies have been analyzed by GNATprove
-- enable analysis of a non-generic body using SPARK_Mode
package Adder is

   function Add (X, Y : in Integer) return Integer with
     Export, Convention => C, SPARK_Mode => On,
     Annotate => (GNATprove, Terminating), Post => (Add'Result = X + Y),
     External_Name      => "add";
   procedure Increment (X : access Integer) with
     Export, Convention => C, SPARK_Mode => On,
     Annotate => (GNATprove, Terminating), Post => (X.all'Old = X.all + 1),
     External_Name      => "increment";

end Adder;
