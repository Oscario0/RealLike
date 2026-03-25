import bisection

open Bisection

/-- Polymorphic quadratic with root `sqrt 2`. -/
def testSqrt2Poly {α : Type} [RealLike α] (x : α) : α := x * x - 2

/-- Polymorphic cubic with one real root in `(1, 2)`. -/
def testCubicPoly {α : Type} [RealLike α] (x : α) : α := x * x * x - x - 1

/-- Polymorphic absolute-value example. -/
def testAbsPoly {α : Type} [RealLike α] (x : α) : α :=
  RealLike.abs (x - (3 : α) / 2) - (1 : α) / 2

/-- Simple addition-only test function with root at `x = -1`. -/
def testAddSimple {α : Type} [RealLike α] (x : α) : α := x + 1

-- Executable `Float` tests.
#eval Bisection.bisectionCore testSqrt2Poly (1.0 : Float) (2.0 : Float) defaultParamsFloat
#eval Bisection.bisectionCore testCubicPoly (1.0 : Float) (2.0 : Float) defaultParamsFloat
#eval Bisection.bisectionCore testAbsPoly (0.5 : Float) (1.5 : Float) defaultParamsFloat

-- Simple addition-only test with an interior root in the interval.
#eval Bisection.bisectionCore testAddSimple (-2.0 : Float) (0.0 : Float) defaultParamsFloat

-- Helper test: near-zero should pass, larger value should fail.
#eval Bisection.isZeroApprox defaultParamsFloat (1e-12 : Float)
#eval Bisection.isZeroApprox defaultParamsFloat (1e-6 : Float)

def testPi (x : Float) : Float := Float.sin x
def testExp (x : Float) : Float := Float.exp x - 2.0

#eval findRoot testPi 3.0 4.0
#eval findRoot testExp 0.0 1.0

-- `ℝ`-specialized examples for theorem statements and reasoning.
noncomputable def testRealQuadratic : BisectionResult ℝ :=
  Bisection.bisectionCore testSqrt2Poly 1 2 defaultParamsReal

noncomputable def testRealCubic : BisectionResult ℝ :=
  Bisection.bisectionCore testCubicPoly 1 2 defaultParamsReal
