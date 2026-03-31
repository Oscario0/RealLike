/-!
# `RealLike.Class` — a typeclass for types that behave like the real numbers

`RealLike α` gives `α` the arithmetic, comparison, and transcendental-function
structure that both `Float` (IEEE 754, computable) and `ℝ` (Mathlib, noncomputable)
share.

## Semantic notes (read before using transcendentals)

Several operations have **different behaviour** on `Float` vs `ℝ` that cannot be
hidden by the typeclass:

| Operation | `Float` | `ℝ` (Mathlib) |
|-----------|---------|---------------|
| `sqrt x` for `x < 0` | `NaN` | `0` |
| `log x` for `x ≤ 0` | `±Inf` / `NaN` | `0` at `x = 0`, `log |x|` for `x < 0` |
| `asin x` for `\|x\| > 1` | `NaN` | clamps to `[-π/2, π/2]` |
| `acos x` for `\|x\| > 1` | `NaN` | clamps to `0` or `π` |
| `pow x y` for `x < 0, y ∉ ℤ` | `NaN` | uses `Real.rpow` (real part of complex power) |
| `round` at half-integers | rounds away from zero | ties round toward +∞ |
| `atan2 y x` | IEEE-style `Float.atan2` | branch in `(-π, π]`; at `(0, 0)`, returns `0` |

`cbrt` is **not** included: `Float.cbrt (-8) = -2.0` but there is no Mathlib
`Real.cbrt` with the same sign behaviour for negative inputs.
-/

class RealLike (α : Type) where
  add   : α → α → α
  mul   : α → α → α
  div   : α → α → α
  neg   : α → α
  le    : α → α → Bool
  lt    : α → α → Bool
  zero  : α
  one   : α
  ofNat : Nat → α
  /-- Real-valued power: maps to `Float.pow` / `Real.rpow`. -/
  pow   : α → α → α
  sqrt  : α → α
  abs   : α → α
  floor : α → α
  ceil  : α → α
  round : α → α
  exp   : α → α
  /-- Natural logarithm. Maps to `Float.log` / `Real.log`. -/
  log   : α → α
  sin   : α → α
  cos   : α → α
  tan   : α → α
  asin  : α → α
  acos  : α → α
  atan  : α → α
  /-- Two-argument arctangent. Signature: `atan2 y x`. -/
  atan2 : α → α → α
  sinh  : α → α
  cosh  : α → α
  tanh  : α → α

instance {α} [RealLike α] : Add α := ⟨RealLike.add⟩
instance {α} [RealLike α] : Mul α := ⟨RealLike.mul⟩
instance {α} [RealLike α] : Div α := ⟨RealLike.div⟩
instance {α} [RealLike α] : Neg α := ⟨RealLike.neg⟩
instance {α} [RealLike α] : Sub α := ⟨fun a b => a + RealLike.neg b⟩
instance {α} [RealLike α] : Zero α := ⟨RealLike.zero⟩
instance {α} [RealLike α] : One α := ⟨RealLike.one⟩
instance {α} [RealLike α] {n : Nat} : OfNat α n := ⟨RealLike.ofNat n⟩
instance {α} [RealLike α] : HPow α α α := ⟨RealLike.pow⟩

private def natPow {α} [RealLike α] (x : α) : Nat → α
  | 0 => 1
  | n + 1 => natPow x n * x

instance {α} [RealLike α] : HPow α Nat α := ⟨fun x n => natPow x n⟩
instance {α} [RealLike α] : OfScientific α where
  ofScientific mantissa exponentSign decimalExponent :=
    let base : α := RealLike.ofNat mantissa
    let scale : α := natPow (α := α) (RealLike.ofNat 10) decimalExponent
    if exponentSign then
      RealLike.div base scale
    else
      RealLike.mul base scale
instance {α} [RealLike α] : LE α := ⟨fun a b => RealLike.le a b = true⟩
instance {α} [RealLike α] : LT α := ⟨fun a b => RealLike.lt a b = true⟩
instance {α} [RealLike α] : Min α := ⟨fun a b => if RealLike.le a b then a else b⟩
instance {α} [RealLike α] : Max α := ⟨fun a b => if RealLike.le b a then a else b⟩
