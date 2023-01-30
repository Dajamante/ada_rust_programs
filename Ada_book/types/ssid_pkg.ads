package SSID_pkg is

-- the type and the package should not have the same name!
    type SSID is new Integer;
-- must be new!
-- type SSID is Integer;

    function Convert(S: SSID) return Integer;
    function Convert(S: SSID) return String;
    function Convert(I: Integer) return String;

end SSID_pkg;