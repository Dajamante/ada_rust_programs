pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Overwriter is
    -- already constructed at compile time
    -- it was never alloc:ed!
    -- Is there a difference to assign a value in a declare zone or after begin
    -- declaring here ends the string in a "constant area"?
    -- Meaning that if I repeatedely call the function I get the same address:
    -- let ada_string_ptr1 = unsafe { allocate_str() };
    -- let ptr1 = ada_string_ptr.ptr;
    -- let ada_string_ptr2 = unsafe { allocate_str() };
    -- let ptr2 = ada_string_ptr.ptr;
    -- This is the output:
    -- Address of Hello in SPARK: (access 55825eae92a8)
    -- Hello pointer1, 0x55825eae92a8
    -- Address of Hello in SPARK: (access 55825eae92a8)
    -- Hello pointer2, 0x55825eae92a8
    -- This is definitely the same address since I get this error message:
    -- free(): double free detected in tcache 2

    -- Hello : String_access := new String'("Hello");

    -- initialisation and assignment are different behavior
    Hello : String_access;

    function Allocate_Str return String_access is
    begin
        -- BUT defining the new String here gives different address!
        -- Address of Hello in SPARK: (access 5641b2eacba8)
        -- Hello pointer1, 0x5641b2eacba8
        -- Address of Hello in SPARK: (access 5641b2eacbc8)
        -- Hello pointer2, 0x5641b2eacbc8
        -- 32/4 bytes, so one pointer?
        Hello := new String'("hello");
        Put_Line ("Address of Hello in SPARK: " & Hello'Img);
        return Hello;
    end Allocate_Str;

    procedure Free_str (S : in out String_access) is
        procedure internal_free is new Ada.Unchecked_Deallocation
           (Object => String, Name => String_access);
    begin
        -- Put_Line ("Image for pointer " & S'Img);
        -- it is happening vvvv
        Put_Line ("Returned string SPARK: " & S.all);
        internal_free (S);
    end Free_str;

end Overwriter;
