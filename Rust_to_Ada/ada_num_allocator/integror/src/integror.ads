pragma Ada_2022;
package Integror is

   type Integer_Access is access all Integer;

   function Allocate_Integer return Integer_Access with
     Export, External_Name => "allocate_integror";

   procedure Free_Integer (Ptr : in out Integer_Access) with
     Export, External_Name => "free_integror";

end Integror;
