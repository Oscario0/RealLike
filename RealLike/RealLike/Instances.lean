import Mathlib.Data.Real.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Algebra.Order.Round
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Complex.Arg
import RealLike.Class

instance : RealLike Float where
  add   := Float.add
  mul   := Float.mul
  div   := Float.div
  neg   := Float.neg
  le a b := a ≤ b
  lt a b := a < b
  zero  := 0.0
  one   := 1.0
  ofNat := Float.ofNat
  pow   := Float.pow
  sqrt  := Float.sqrt
  abs   := Float.abs
  floor := Float.floor
  ceil  := Float.ceil
  round := Float.round
  exp   := Float.exp
  log   := Float.log
  sin   := Float.sin
  cos   := Float.cos
  tan   := Float.tan
  asin  := Float.asin
  acos  := Float.acos
  atan  := Float.atan
  atan2 := Float.atan2
  sinh  := Float.sinh
  cosh  := Float.cosh
  tanh  := Float.tanh

noncomputable instance : RealLike ℝ where
  add   := (· + ·)
  mul   := (· * ·)
  div   := (· / ·)
  neg   := Neg.neg
  le a b := decide (a ≤ b)
  lt a b := decide (a < b)
  zero  := 0
  one   := 1
  ofNat := fun n => n
  pow   := Real.rpow
  sqrt  := Real.sqrt
  abs   := fun x => |x|
  floor := fun x => (⌊x⌋ : ℝ)
  ceil  := fun x => (⌈x⌉ : ℝ)
  round := fun x => (round x : ℝ)
  exp   := Real.exp
  log   := Real.log
  sin   := Real.sin
  cos   := Real.cos
  tan   := Real.tan
  asin  := Real.arcsin
  acos  := Real.arccos
  atan  := Real.arctan
  atan2 := fun y x => Complex.arg ⟨x, y⟩
  sinh  := Real.sinh
  cosh  := Real.cosh
  tanh  := Real.tanh
