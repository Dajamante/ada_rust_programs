package body SSID_pkg is

    function Convert(S: SSID) return Integer is
    -- forgot ;
    -- forgot begins!
    begin
        return 7;
    end Convert;

    function Convert(S: SSID) return String is
    begin
        return "9";
    end Convert;

-- no returns
    function Convert(I: Integer) return String is
    begin
        return "457";
    end Convert;
end SSID_pkg;