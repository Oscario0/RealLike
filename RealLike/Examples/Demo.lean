import RealLike
import RealLike.Evalf

/-!
# Demo: `#evalf` and `evalf%` on `RealLike`-polymorphic functions

Write functions once against `[RealLike α]`, prove facts by instantiating `α := ℝ`,
and evaluate numerically by instantiating `α := Float`.
-/

-- Polymorphic definitions: already written against `[RealLike α]`.

def linear {α} [RealLike α] (x : α) : α := (x + 5) / 6
#evalf linear 3
#evalf linear (-5)

def quadratic {α} [RealLike α] (x : α) : α := x * x - 4 * x + 4
#evalf quadratic 2
#evalf quadratic 5

def dot2 {α} [RealLike α] (x y : α) : α := x * x + y * y
#evalf dot2 3 4

def composition {α} [RealLike α] (x y : α) : α := dot2 (linear x) (quadratic y)
#evalf composition 3 2
#evalf composition 3 5

def hypotenuse {α} [RealLike α] (a b : α) : α := RealLike.sqrt (a * a + b * b)
#evalf hypotenuse 3 4

def normalise {α} [RealLike α] (x : α) : α := x / RealLike.sqrt (x * x + 1)
#evalf normalise 0
#evalf normalise 1

def growthModel {α} [RealLike α] (r t : α) : α := RealLike.exp (r * t)
#evalf growthModel 0.1 10

def halfLife {α} [RealLike α] (rate t : α) : α := RealLike.exp (-(rate * t))
#evalf halfLife 0.693 1

def logReturn {α} [RealLike α] (p0 p1 : α) : α := RealLike.log (p1 / p0)
#evalf logReturn 100 110

def sinc {α} [RealLike α] (x : α) : α := RealLike.sin x / x
#evalf sinc 1

def pbc {α} [RealLike α] (x L : α) : α := x - L * RealLike.round (x / L)
#evalf pbc 3 2
#evalf pbc 7 5
#evalf pbc (-3) 2

def polarX {α} [RealLike α] (r θ : α) : α := r * RealLike.cos θ
def polarY {α} [RealLike α] (r θ : α) : α := r * RealLike.sin θ
#evalf polarX 1 0
#evalf polarY 1 0

#eval (evalf% linear 3)
#eval (evalf% hypotenuse 3.0 4.0)
#eval (evalf% growthModel 1.0 1.0)

-- Concrete `ℝ` definitions: lowered to `RealLike`, then specialized to `Float`.

noncomputable def linearR (x : ℝ) : ℝ := (x + 5) / 6
#evalf linearR 3
#evalf linearR (-5)

noncomputable def quadraticR (x : ℝ) : ℝ := x * x - 4 * x + 4
#evalf quadraticR 2
#evalf quadraticR 5

noncomputable def hypotenuseR (a b : ℝ) : ℝ := Real.sqrt (a * a + b * b)
#evalf hypotenuseR 3 4

noncomputable def growthModelR (r t : ℝ) : ℝ := Real.exp (r * t)
#evalf growthModelR 0.1 10

noncomputable def compositionR (x y : ℝ) : ℝ := linearR x + quadraticR y
#evalf compositionR 3 5

#eval (evalf% linearR 3)

noncomputable def pbcR (x L : ℝ) : ℝ := x - L * (_root_.round (x / L))

#evalf pbcR 3 2
#evalf pbcR 7 5
#evalf pbcR (-3) 2
