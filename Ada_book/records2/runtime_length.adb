with Ada.Text_IO; use Ada.Text_IO;

package body Runtime_Length is

    function Compute_Max_Len (S : String) return Natural is
        -- missing begin
        -- runtime_length.adb:7:21: error: attribute "Value" may not be used in a subtype mark
        -- I : Integer'Value (S);
        I : Integer := Integer'Value (S);
    begin
        -- Integer Val' vs Integer Value
        -- runtime_length.adb:6:16: error: "Get" is undefined
        return I;
    end Compute_Max_Len;

end Runtime_Length;
