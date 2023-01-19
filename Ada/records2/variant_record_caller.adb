with Ada.Text_IO;     use Ada.Text_IO;
with Variant_records; use Variant_records;

procedure Variant_record_caller is
    function Expr_evaluator (E : Expr) return Integer is
    -- missing begin
    -- begin
    -- but this funciton has no begin!!
    -- missplaced return

       (case E.Kind is
    -- does the return works like Rust
    -- return cannot be here also!

           when Plus =>
              Expr_evaluator (E.Left.all) + Expr_evaluator (E.right.all),
           when Minus =>
              Expr_evaluator (E.Left.all) - Expr_evaluator (E.right.all),
           when Num => E.Val);
    -- does it need an end?
    -- and no end case!
    -- end case;
    -- and no end??
    -- end Expr_evaluator;

-- a function that evaluates expression
-- why the fnut
-- this is an expr and not a pointer
    --E : Expr := new Expr'(Plus, new Expr'(Num, 14), new Expr'(Num, 15));
    E : Expr :=
       (Plus, new Expr'(Plus, new Expr'(Num, 6), new Expr'(num, -9)),
        new Expr'(Num, 8));
begin
    Put_Line (Integer'Image (Expr_evaluator (E)));
end Variant_record_caller;
