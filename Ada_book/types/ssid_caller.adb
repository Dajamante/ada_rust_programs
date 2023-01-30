with Ada.TEXT_IO; use Ada.Text_IO;
with SSID_pkg; use SSID_pkg;

procedure Ssid_caller is
    A: SSID := 1_234;
    B: Integer := 1_234;
    S: String := Convert(SSID'(7_898));

    T: SSID := SSID'(9);
    U: Integer := Integer'(12);
    U_conv: String := Convert(U);

    begin
    -- no parenthesis attribute designation error
    -- two end give EoF expected
    -- end;
    Put_line("S " & S);

    Put_line("T " & T'Img);
    Put_line("U " & U'Img);

    Put_line("U_conv " & U_conv);

end Ssid_caller;
