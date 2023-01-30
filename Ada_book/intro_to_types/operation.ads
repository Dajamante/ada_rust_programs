package Operation is
    function Increment_by
       (I : Integer := 0; Incr : Integer := 1) return Integer;

-- I forgot return here too!
    function Get_last_increment return Integer;

-- must be type concordant, display adb took some params!
    procedure Display (I : Integer; Incr : Integer);

end Operation;
