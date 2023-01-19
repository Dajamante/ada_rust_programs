package Variant_records is

-- type Expr forward
    type Expr;

-- enum
    type Expr_kind is (Plus, Minus, Num);

    type Expr_access is access Expr;

    type Expr (Kind : Expr_kind) is record
        case Kind is
            when Plus | Minus =>
                Left, Right : Expr_access;
            when Num =>
                Val : Integer;
        end case;
    end record;
-- an access to the expression
-- type expr with discriminant and case

end Variant_records;
