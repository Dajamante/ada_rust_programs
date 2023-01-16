with Ada.Text_IO; use Ada.Text_IO;

procedure Enumeration is
    type Days is
    -- Dumb question but can't we have those in small letters?

       (Monday, Tuesday, Wenesday, Thursday, Friday, Saturday, Sunday);
    type Weekend_day is new Days range Saturday .. Sunday;
    -- No new to subtype
    subtype Prewekend is Days range Thursday .. Days'Last;

begin
    for H in Prewekend loop
        Put_Line (Days'Image (H));
    end loop;

    for J in Weekend_day loop
        case J is
            when Saturday =>
                Put_Line ("Today is :" & Weekend_day'Image (J));
            when Sunday =>
                -- it is not a subtype of Days!
                Put_Line ("End of we: " & Weekend_day'Image (J));
        end case;
    end loop;
-- no range in this for loop
    for I in Days loop
        case I is
            when Saturday | Sunday =>
                Put_Line ("Weekend");
                -- enumeration.adb:10:09: error: missing case values: "Monday" .. "Friday"
                -- check what is not operator
            when Monday .. Friday =>
                -- forgot I after image again!
                Put_Line ("Hello from " & Days'Image (I));
        end case;
    end loop;
end Enumeration;
