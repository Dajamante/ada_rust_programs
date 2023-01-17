package Colors is

type Color is (Blue, Red, Orange, Cyan, Yellow);

type Color_array is array (Positive range <>) of Color;

procedure Reverse_it(A: in out Color_array);

-- shall I declare my array here, or in the body?

end Colors;