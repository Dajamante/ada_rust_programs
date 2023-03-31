with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;
package body Integror is

    function Allocate_Integer return Integer_Access is
        Ptr : Integer_Access := new Integer'(42);
    begin
        --Put_Line ("Our address : " & Integer_Access'Image (Ptr));
        return Ptr;
    end Allocate_Integer;

    procedure Free_Integer (Ptr : in out Integer_Access) is
        procedure Internal_Free is new Ada.Unchecked_Deallocation
           (Object => Integer, Name => Integer_Access);
    begin
        Put_Line ("Got this back " & Integer'Image (Ptr.all));
        Internal_Free (Ptr);
    end Free_Integer;

end Integror;
