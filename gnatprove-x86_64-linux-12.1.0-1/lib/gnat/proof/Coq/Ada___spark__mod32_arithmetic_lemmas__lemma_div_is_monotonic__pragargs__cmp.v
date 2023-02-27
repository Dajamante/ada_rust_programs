





(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below *)
Require Import BuiltIn.
Require BuiltIn.
Require int.Int.
Require int.Abs.
Require int.MinMax.
Require int.EuclideanDivision.
Require bool.Bool.
Require bv.Pow2int.
Require bv.BV_Gen.

Axiom us_private : Type.
Parameter us_private_WhyType : WhyType us_private.
Existing Instance us_private_WhyType.

(* Why3 assumption *)
Definition us_fixed := Numbers.BinNums.Z.

Parameter private__bool_eq: us_private -> us_private -> Init.Datatypes.bool.

Parameter us_null_ext__: us_private.

Axiom us_type_of_heap : Type.
Parameter us_type_of_heap_WhyType : WhyType us_type_of_heap.
Existing Instance us_type_of_heap_WhyType.

(* Why3 assumption *)
Inductive us_type_of_heap__ref :=
  | us_type_of_heap__ref'mk : us_type_of_heap -> us_type_of_heap__ref.
Axiom us_type_of_heap__ref_WhyType : WhyType us_type_of_heap__ref.
Existing Instance us_type_of_heap__ref_WhyType.

(* Why3 assumption *)
Definition us_type_of_heap__content (v:us_type_of_heap__ref) :
    us_type_of_heap :=
  match v with
  | us_type_of_heap__ref'mk x => x
  end.

Axiom us_image : Type.
Parameter us_image_WhyType : WhyType us_image.
Existing Instance us_image_WhyType.

(* Why3 assumption *)
Inductive int__ref :=
  | int__ref'mk : Numbers.BinNums.Z -> int__ref.
Axiom int__ref_WhyType : WhyType int__ref.
Existing Instance int__ref_WhyType.

(* Why3 assumption *)
Definition int__content (v:int__ref) : Numbers.BinNums.Z :=
  match v with
  | int__ref'mk x => x
  end.

(* Why3 assumption *)
Inductive bool__ref :=
  | bool__ref'mk : Init.Datatypes.bool -> bool__ref.
Axiom bool__ref_WhyType : WhyType bool__ref.
Existing Instance bool__ref_WhyType.

(* Why3 assumption *)
Definition bool__content (v:bool__ref) : Init.Datatypes.bool :=
  match v with
  | bool__ref'mk x => x
  end.

(* Why3 assumption *)
Inductive us_fixed__ref :=
  | us_fixed__ref'mk : Numbers.BinNums.Z -> us_fixed__ref.
Axiom us_fixed__ref_WhyType : WhyType us_fixed__ref.
Existing Instance us_fixed__ref_WhyType.

(* Why3 assumption *)
Definition us_fixed__content (v:us_fixed__ref) : Numbers.BinNums.Z :=
  match v with
  | us_fixed__ref'mk x => x
  end.

(* Why3 assumption *)
Inductive real__ref :=
  | real__ref'mk : Reals.Rdefinitions.R -> real__ref.
Axiom real__ref_WhyType : WhyType real__ref.
Existing Instance real__ref_WhyType.

(* Why3 assumption *)
Definition real__content (v:real__ref) : Reals.Rdefinitions.R :=
  match v with
  | real__ref'mk x => x
  end.

(* Why3 assumption *)
Inductive us_private__ref :=
  | us_private__ref'mk : us_private -> us_private__ref.
Axiom us_private__ref_WhyType : WhyType us_private__ref.
Existing Instance us_private__ref_WhyType.

(* Why3 assumption *)
Definition us_private__content (v:us_private__ref) : us_private :=
  match v with
  | us_private__ref'mk x => x
  end.

(* Why3 assumption *)
Definition int__ref___projection (a:int__ref) : Numbers.BinNums.Z :=
  int__content a.

(* Why3 assumption *)
Definition us_fixed__ref___projection (a:us_fixed__ref) : Numbers.BinNums.Z :=
  us_fixed__content a.

(* Why3 assumption *)
Definition bool__ref___projection (a:bool__ref) : Init.Datatypes.bool :=
  bool__content a.

(* Why3 assumption *)
Definition real__ref___projection (a:real__ref) : Reals.Rdefinitions.R :=
  real__content a.

(* Why3 assumption *)
Definition us_private__ref___projection (a:us_private__ref) : us_private :=
  us_private__content a.

Axiom t : Type.
Parameter t_WhyType : WhyType t.
Existing Instance t_WhyType.

Parameter t'int: t -> Numbers.BinNums.Z.

Axiom t'axiom :
  forall (i:t), (0%Z <= (t'int i))%Z /\ ((t'int i) <= 4294967295%Z)%Z.

Parameter nth: t -> Numbers.BinNums.Z -> Init.Datatypes.bool.

Axiom nth_out_of_bound :
  forall (x:t) (n:Numbers.BinNums.Z), (n < 0%Z)%Z \/ (32%Z <= n)%Z ->
  ((nth x n) = Init.Datatypes.false).

Parameter zeros: t.

Axiom Nth_zeros :
  forall (n:Numbers.BinNums.Z), ((nth zeros n) = Init.Datatypes.false).

Parameter one: t.

Parameter ones: t.

Axiom Nth_ones :
  forall (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth ones n) = Init.Datatypes.true).

Parameter bw_and: t -> t -> t.

Axiom Nth_bw_and :
  forall (v1:t) (v2:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth (bw_and v1 v2) n) = (Init.Datatypes.andb (nth v1 n) (nth v2 n))).

Parameter bw_or: t -> t -> t.

Axiom Nth_bw_or :
  forall (v1:t) (v2:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth (bw_or v1 v2) n) = (Init.Datatypes.orb (nth v1 n) (nth v2 n))).

Parameter bw_xor: t -> t -> t.

Axiom Nth_bw_xor :
  forall (v1:t) (v2:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth (bw_xor v1 v2) n) = (Init.Datatypes.xorb (nth v1 n) (nth v2 n))).

Parameter bw_not: t -> t.

Axiom Nth_bw_not :
  forall (v:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth (bw_not v) n) = (Init.Datatypes.negb (nth v n))).

Parameter lsr: t -> Numbers.BinNums.Z -> t.

Axiom Lsr_nth_low :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z), (0%Z <= s)%Z ->
  (0%Z <= n)%Z -> ((n + s)%Z < 32%Z)%Z ->
  ((nth (lsr b s) n) = (nth b (n + s)%Z)).

Axiom Lsr_nth_high :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z), (0%Z <= s)%Z ->
  (0%Z <= n)%Z -> (32%Z <= (n + s)%Z)%Z ->
  ((nth (lsr b s) n) = Init.Datatypes.false).

Axiom lsr_zeros : forall (x:t), ((lsr x 0%Z) = x).

Parameter asr: t -> Numbers.BinNums.Z -> t.

Axiom Asr_nth_low :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z), (0%Z <= s)%Z ->
  (0%Z <= n)%Z /\ (n < 32%Z)%Z -> ((n + s)%Z < 32%Z)%Z ->
  ((nth (asr b s) n) = (nth b (n + s)%Z)).

Axiom Asr_nth_high :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z), (0%Z <= s)%Z ->
  (0%Z <= n)%Z /\ (n < 32%Z)%Z -> (32%Z <= (n + s)%Z)%Z ->
  ((nth (asr b s) n) = (nth b (32%Z - 1%Z)%Z)).

Axiom asr_zeros : forall (x:t), ((asr x 0%Z) = x).

Parameter lsl: t -> Numbers.BinNums.Z -> t.

Axiom Lsl_nth_high :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z),
  (0%Z <= s)%Z /\ (s <= n)%Z /\ (n < 32%Z)%Z ->
  ((nth (lsl b s) n) = (nth b (n - s)%Z)).

Axiom Lsl_nth_low :
  forall (b:t) (n:Numbers.BinNums.Z) (s:Numbers.BinNums.Z),
  (0%Z <= n)%Z /\ (n < s)%Z -> ((nth (lsl b s) n) = Init.Datatypes.false).

Axiom lsl_zeros : forall (x:t), ((lsl x 0%Z) = x).

Parameter rotate_right: t -> Numbers.BinNums.Z -> t.

Axiom Nth_rotate_right :
  forall (v:t) (n:Numbers.BinNums.Z) (i:Numbers.BinNums.Z),
  (0%Z <= i)%Z /\ (i < 32%Z)%Z -> (0%Z <= n)%Z ->
  ((nth (rotate_right v n) i) =
   (nth v (int.EuclideanDivision.mod1 (i + n)%Z 32%Z))).

Parameter rotate_left: t -> Numbers.BinNums.Z -> t.

Axiom Nth_rotate_left :
  forall (v:t) (n:Numbers.BinNums.Z) (i:Numbers.BinNums.Z),
  (0%Z <= i)%Z /\ (i < 32%Z)%Z -> (0%Z <= n)%Z ->
  ((nth (rotate_left v n) i) =
   (nth v (int.EuclideanDivision.mod1 (i - n)%Z 32%Z))).

Parameter is_signed_positive: t -> Prop.

Parameter of_int: Numbers.BinNums.Z -> t.

Parameter to_int: t -> Numbers.BinNums.Z.

Axiom to_int'def :
  forall (x:t),
  (is_signed_positive x -> ((to_int x) = (t'int x))) /\ (* non escaped EOL for cpp parsing *)
  (~ is_signed_positive x ->
   ((to_int x) = (-(4294967296%Z - (t'int x))%Z)%Z)).

Axiom to_uint_extensionality :
  forall (v:t) (v':t), ((t'int v) = (t'int v')) -> (v = v').

Axiom to_int_extensionality :
  forall (v:t) (v':t), ((to_int v) = (to_int v')) -> (v = v').

(* Why3 assumption *)
Definition uint_in_range (i:Numbers.BinNums.Z) : Prop :=
  (0%Z <= i)%Z /\ (i <= 4294967295%Z)%Z.

Axiom to_uint_bounds :
  forall (v:t), (0%Z <= (t'int v))%Z /\ ((t'int v) < 4294967296%Z)%Z.

Axiom to_uint_of_int :
  forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < 4294967296%Z)%Z ->
  ((t'int (of_int i)) = i).

Parameter size_bv: t.

Axiom to_uint_size_bv : ((t'int size_bv) = 32%Z).

Axiom to_uint_zeros : ((t'int zeros) = 0%Z).

Axiom to_uint_one : ((t'int one) = 1%Z).

Axiom to_uint_ones : ((t'int ones) = 4294967295%Z).

(* Why3 assumption *)
Definition ult (x:t) (y:t) : Prop := ((t'int x) < (t'int y))%Z.

(* Why3 assumption *)
Definition ule (x:t) (y:t) : Prop := ((t'int x) <= (t'int y))%Z.

(* Why3 assumption *)
Definition ugt (x:t) (y:t) : Prop := ((t'int y) < (t'int x))%Z.

(* Why3 assumption *)
Definition uge (x:t) (y:t) : Prop := ((t'int y) <= (t'int x))%Z.

(* Why3 assumption *)
Definition slt (v1:t) (v2:t) : Prop := ((to_int v1) < (to_int v2))%Z.

(* Why3 assumption *)
Definition sle (v1:t) (v2:t) : Prop := ((to_int v1) <= (to_int v2))%Z.

(* Why3 assumption *)
Definition sgt (v1:t) (v2:t) : Prop := ((to_int v2) < (to_int v1))%Z.

(* Why3 assumption *)
Definition sge (v1:t) (v2:t) : Prop := ((to_int v2) <= (to_int v1))%Z.

Axiom positive_is_ge_zeros :
  forall (x:t), is_signed_positive x <-> sge x zeros.

Parameter add: t -> t -> t.

Axiom to_uint_add :
  forall (v1:t) (v2:t),
  ((t'int (add v1 v2)) =
   (int.EuclideanDivision.mod1 ((t'int v1) + (t'int v2))%Z 4294967296%Z)).

Axiom to_uint_add_bounded :
  forall (v1:t) (v2:t), (((t'int v1) + (t'int v2))%Z < 4294967296%Z)%Z ->
  ((t'int (add v1 v2)) = ((t'int v1) + (t'int v2))%Z).

Parameter sub: t -> t -> t.

Axiom to_uint_sub :
  forall (v1:t) (v2:t),
  ((t'int (sub v1 v2)) =
   (int.EuclideanDivision.mod1 ((t'int v1) - (t'int v2))%Z 4294967296%Z)).

Axiom to_uint_sub_bounded :
  forall (v1:t) (v2:t),
  (0%Z <= ((t'int v1) - (t'int v2))%Z)%Z /\ (* non escaped EOL for cpp parsing *)
  (((t'int v1) - (t'int v2))%Z < 4294967296%Z)%Z ->
  ((t'int (sub v1 v2)) = ((t'int v1) - (t'int v2))%Z).

Parameter neg: t -> t.

Axiom to_uint_neg :
  forall (v:t),
  ((t'int (neg v)) =
   (int.EuclideanDivision.mod1 (-(t'int v))%Z 4294967296%Z)).

Parameter mul: t -> t -> t.

Axiom to_uint_mul :
  forall (v1:t) (v2:t),
  ((t'int (mul v1 v2)) =
   (int.EuclideanDivision.mod1 ((t'int v1) * (t'int v2))%Z 4294967296%Z)).

Axiom to_uint_mul_bounded :
  forall (v1:t) (v2:t), (((t'int v1) * (t'int v2))%Z < 4294967296%Z)%Z ->
  ((t'int (mul v1 v2)) = ((t'int v1) * (t'int v2))%Z).

Parameter udiv: t -> t -> t.

Axiom to_uint_udiv :
  forall (v1:t) (v2:t),
  ((t'int (udiv v1 v2)) = (int.EuclideanDivision.div (t'int v1) (t'int v2))).

Parameter urem: t -> t -> t.

Axiom to_uint_urem :
  forall (v1:t) (v2:t),
  ((t'int (urem v1 v2)) = (int.EuclideanDivision.mod1 (t'int v1) (t'int v2))).

Parameter lsr_bv: t -> t -> t.

Axiom lsr_bv_is_lsr : forall (x:t) (n:t), ((lsr_bv x n) = (lsr x (t'int n))).

Axiom to_uint_lsr :
  forall (v:t) (n:t),
  ((t'int (lsr_bv v n)) =
   (int.EuclideanDivision.div (t'int v) (bv.Pow2int.pow2 (t'int n)))).

Parameter asr_bv: t -> t -> t.

Axiom asr_bv_is_asr : forall (x:t) (n:t), ((asr_bv x n) = (asr x (t'int n))).

Parameter lsl_bv: t -> t -> t.

Axiom lsl_bv_is_lsl : forall (x:t) (n:t), ((lsl_bv x n) = (lsl x (t'int n))).

Axiom to_uint_lsl :
  forall (v:t) (n:t),
  ((t'int (lsl_bv v n)) =
   (int.EuclideanDivision.mod1 ((t'int v) * (bv.Pow2int.pow2 (t'int n)))%Z
    4294967296%Z)).

Parameter rotate_right_bv: t -> t -> t.

Parameter rotate_left_bv: t -> t -> t.

Axiom rotate_left_bv_is_rotate_left :
  forall (v:t) (n:t), ((rotate_left_bv v n) = (rotate_left v (t'int n))).

Axiom rotate_right_bv_is_rotate_right :
  forall (v:t) (n:t), ((rotate_right_bv v n) = (rotate_right v (t'int n))).

Parameter nth_bv: t -> t -> Init.Datatypes.bool.

Axiom nth_bv_def :
  forall (x:t) (i:t),
  ((nth_bv x i) = Init.Datatypes.true) <->
  ~ ((bw_and (lsr_bv x i) one) = zeros).

Axiom Nth_bv_is_nth : forall (x:t) (i:t), ((nth x (t'int i)) = (nth_bv x i)).

Axiom Nth_bv_is_nth2 :
  forall (x:t) (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < 4294967296%Z)%Z ->
  ((nth_bv x (of_int i)) = (nth x i)).

Parameter eq_sub_bv: t -> t -> t -> t -> Prop.

Axiom eq_sub_bv_def :
  forall (a:t) (b:t) (i:t) (n:t),
  let mask := lsl_bv (sub (lsl_bv one n) one) i in
  eq_sub_bv a b i n <-> ((bw_and b mask) = (bw_and a mask)).

(* Why3 assumption *)
Definition eq_sub (a:t) (b:t) (i:Numbers.BinNums.Z) (n:Numbers.BinNums.Z) :
    Prop :=
  forall (j:Numbers.BinNums.Z), (i <= j)%Z /\ (j < (i + n)%Z)%Z ->
  ((nth a j) = (nth b j)).

Axiom eq_sub_equiv :
  forall (a:t) (b:t) (i:t) (n:t),
  eq_sub a b (t'int i) (t'int n) <-> eq_sub_bv a b i n.

Axiom Extensionality : forall (x:t) (y:t), eq_sub x y 0%Z 32%Z -> (x = y).

(* Why3 assumption *)
Inductive t__ref :=
  | t__ref'mk : t -> t__ref.
Axiom t__ref_WhyType : WhyType t__ref.
Existing Instance t__ref_WhyType.

(* Why3 assumption *)
Definition t__content (v:t__ref) : t := match v with
                                        | t__ref'mk x => x
                                        end.

Parameter bool_eq: t -> t -> Init.Datatypes.bool.

Axiom bool_eq'def :
  forall (x:t) (y:t),
  ((x = y) -> ((bool_eq x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ (x = y) -> ((bool_eq x y) = Init.Datatypes.false)).

Parameter bool_ne: t -> t -> Init.Datatypes.bool.

Axiom bool_ne'def :
  forall (x:t) (y:t),
  (~ (x = y) -> ((bool_ne x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  ((x = y) -> ((bool_ne x y) = Init.Datatypes.false)).

Parameter bool_lt: t -> t -> Init.Datatypes.bool.

Axiom bool_lt'def :
  forall (x:t) (y:t),
  (ult x y -> ((bool_lt x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ ult x y -> ((bool_lt x y) = Init.Datatypes.false)).

Parameter bool_le: t -> t -> Init.Datatypes.bool.

Axiom bool_le'def :
  forall (x:t) (y:t),
  (ule x y -> ((bool_le x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ ule x y -> ((bool_le x y) = Init.Datatypes.false)).

Parameter bool_gt: t -> t -> Init.Datatypes.bool.

Axiom bool_gt'def :
  forall (x:t) (y:t),
  (ugt x y -> ((bool_gt x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ ugt x y -> ((bool_gt x y) = Init.Datatypes.false)).

Parameter bool_ge: t -> t -> Init.Datatypes.bool.

Axiom bool_ge'def :
  forall (x:t) (y:t),
  (uge x y -> ((bool_ge x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ uge x y -> ((bool_ge x y) = Init.Datatypes.false)).

Parameter power: t -> Numbers.BinNums.Z -> t.

Axiom Power_0 : forall (x:t), ((power x 0%Z) = one).

Axiom Power_1 : forall (x:t), ((power x 1%Z) = x).

Axiom Power_s :
  forall (x:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z ->
  ((power x (n + 1%Z)%Z) = (mul x (power x n))).

Axiom Power_s_alt :
  forall (x:t) (n:Numbers.BinNums.Z), (0%Z < n)%Z ->
  ((power x n) = (mul x (power x (n - 1%Z)%Z))).

Axiom Power_sum :
  forall (x:t) (n:Numbers.BinNums.Z) (m:Numbers.BinNums.Z), (0%Z <= n)%Z ->
  (0%Z <= m)%Z -> ((power x (n + m)%Z) = (mul (power x n) (power x m))).

Axiom Power_mult :
  forall (x:t) (n:Numbers.BinNums.Z) (m:Numbers.BinNums.Z), (0%Z <= n)%Z ->
  (0%Z <= m)%Z -> ((power x (n * m)%Z) = (power (power x n) m)).

Axiom Power_mult2 :
  forall (x:t) (y:t) (n:Numbers.BinNums.Z), (0%Z <= n)%Z ->
  ((power (mul x y) n) = (mul (power x n) (power y n))).

Parameter bv_min: t -> t -> t.

Axiom bv_min'def :
  forall (x:t) (y:t),
  (ule x y -> ((bv_min x y) = x)) /\ (~ ule x y -> ((bv_min x y) = y)).

Parameter bv_max: t -> t -> t.

Axiom bv_max'def :
  forall (x:t) (y:t),
  (ule x y -> ((bv_max x y) = y)) /\ (~ ule x y -> ((bv_max x y) = x)).

Axiom bv_min_to_uint :
  forall (x:t) (y:t),
  ((t'int (bv_min x y)) = (ZArith.BinInt.Z.min (t'int x) (t'int y))).

Axiom bv_max_to_uint :
  forall (x:t) (y:t),
  ((t'int (bv_max x y)) = (ZArith.BinInt.Z.max (t'int x) (t'int y))).

Parameter val1: t.

Parameter attr__ATTRIBUTE_ADDRESS: Numbers.BinNums.Z.

Parameter val2: t.

Parameter attr__ATTRIBUTE_ADDRESS1: Numbers.BinNums.Z.

Parameter denom: t.

Parameter attr__ATTRIBUTE_ADDRESS2: Numbers.BinNums.Z.

Axiom unsigned_32 : Type.
Parameter unsigned_32_WhyType : WhyType unsigned_32.
Existing Instance unsigned_32_WhyType.

Parameter attr__ATTRIBUTE_MODULUS: t.

(* Why3 assumption *)
Definition rep_type := t.

Parameter bool_eq1: t -> t -> Init.Datatypes.bool.

Axiom bool_eq'def1 :
  forall (x:t) (y:t),
  ((x = y) -> ((bool_eq1 x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ (x = y) -> ((bool_eq1 x y) = Init.Datatypes.false)).

Parameter attr__ATTRIBUTE_IMAGE: t -> us_image.

Parameter attr__ATTRIBUTE_VALUE__pre_check: us_image -> Prop.

Parameter attr__ATTRIBUTE_VALUE: us_image -> t.

Parameter user_eq: unsigned_32 -> unsigned_32 -> Init.Datatypes.bool.

Parameter dummy: unsigned_32.

(* Why3 assumption *)
Inductive unsigned_32__ref :=
  | unsigned_32__ref'mk : unsigned_32 -> unsigned_32__ref.
Axiom unsigned_32__ref_WhyType : WhyType unsigned_32__ref.
Existing Instance unsigned_32__ref_WhyType.

(* Why3 assumption *)
Definition unsigned_32__content (v:unsigned_32__ref) : unsigned_32 :=
  match v with
  | unsigned_32__ref'mk x => x
  end.

(* Why3 assumption *)
Definition unsigned_32__ref_unsigned_32__content__projection
    (a:unsigned_32__ref) : unsigned_32 :=
  unsigned_32__content a.

Parameter rliteral: t.

Axiom rliteral_axiom : ((t'int rliteral) = 0%Z).

Parameter rliteral1: t.

Axiom rliteral_axiom1 : ((t'int rliteral1) = 4294967295%Z).

(* Why3 assumption *)
Definition dynamic_invariant (temp___expr_165:t)
    (temp___is_init_161:Init.Datatypes.bool)
    (temp___skip_constant_162:Init.Datatypes.bool)
    (temp___do_toplevel_163:Init.Datatypes.bool)
    (temp___do_typ_inv_164:Init.Datatypes.bool) : Prop :=
  True.

Axiom pos : Type.
Parameter pos_WhyType : WhyType pos.
Existing Instance pos_WhyType.

Parameter attr__ATTRIBUTE_MODULUS1: t.

Parameter rliteral2: t.

Axiom rliteral_axiom2 : ((t'int rliteral2) = 1%Z).

(* Why3 assumption *)
Definition in_range (x:t) : Prop := ule rliteral2 x /\ ule x rliteral1.

(* Why3 assumption *)
Definition in_range_int (x:Numbers.BinNums.Z) : Prop :=
  (1%Z <= x)%Z /\ (x <= 4294967295%Z)%Z.

(* Why3 assumption *)
Definition rep_type1 := t.

Parameter bool_eq2: t -> t -> Init.Datatypes.bool.

Axiom bool_eq'def2 :
  forall (x:t) (y:t),
  ((x = y) -> ((bool_eq2 x y) = Init.Datatypes.true)) /\ (* non escaped EOL for cpp parsing *)
  (~ (x = y) -> ((bool_eq2 x y) = Init.Datatypes.false)).

Parameter attr__ATTRIBUTE_IMAGE1: t -> us_image.

Parameter attr__ATTRIBUTE_VALUE__pre_check1: us_image -> Prop.

Parameter attr__ATTRIBUTE_VALUE1: us_image -> t.

Parameter user_eq1: pos -> pos -> Init.Datatypes.bool.

Parameter dummy1: pos.

(* Why3 assumption *)
Inductive pos__ref :=
  | pos__ref'mk : pos -> pos__ref.
Axiom pos__ref_WhyType : WhyType pos__ref.
Existing Instance pos__ref_WhyType.

(* Why3 assumption *)
Definition pos__content (v:pos__ref) : pos :=
  match v with
  | pos__ref'mk x => x
  end.

(* Why3 assumption *)
Definition pos__ref_pos__content__projection (a:pos__ref) : pos :=
  pos__content a.

(* Why3 assumption *)
Definition dynamic_invariant1 (temp___expr_172:t)
    (temp___is_init_168:Init.Datatypes.bool)
    (temp___skip_constant_169:Init.Datatypes.bool)
    (temp___do_toplevel_170:Init.Datatypes.bool)
    (temp___do_typ_inv_171:Init.Datatypes.bool) : Prop :=
  (temp___is_init_168 = Init.Datatypes.true) \/ ule rliteral2 rliteral1 ->
  in_range temp___expr_172.

(* Why3 goal *)
Theorem def'vc :
  dynamic_invariant val1 Init.Datatypes.true Init.Datatypes.false
  Init.Datatypes.true Init.Datatypes.true ->
  dynamic_invariant val2 Init.Datatypes.true Init.Datatypes.false
  Init.Datatypes.true Init.Datatypes.true ->
  dynamic_invariant1 denom Init.Datatypes.true Init.Datatypes.false
  Init.Datatypes.true Init.Datatypes.true -> ule val1 val2 ->
  ule (udiv val1 denom) (udiv val2 denom).
Proof.

intros dummy dummy2 denom_type pre.
Open Scope Z_scope.

(* rewrite hypotheses *)
unfold dynamic_invariant, in_range in denom_type.
destruct denom_type as (denom_lb, denom_ub); auto.
unfold ule in denom_lb, denom_ub, pre.
rewrite rliteral_axiom2 in denom_lb.
rewrite rliteral_axiom1 in denom_ub.

(* rewrite goal *)
unfold ule.
rewrite to_uint_udiv, to_uint_udiv.
unfold EuclideanDivision.div.
case Z_le_dec; [intros|intros neg_hyp; contradict neg_hyp; apply Z_mod_lt; auto with zarith].
case Z_le_dec; [intros|intros neg_hyp; contradict neg_hyp; apply Z_mod_lt; auto with zarith].

(* apply arithmetic theorem *)
apply Z.div_le_mono; auto with zarith.

Qed.

