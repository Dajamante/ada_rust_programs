package Points is

    type Point (X, Y : Integer := 0) is record
        null;
    end record;

    -- unconstrained subtype
    P  : Point;
    P1 : Point := (1, 2);
    P2 : Point (1, 2);

end Points;
