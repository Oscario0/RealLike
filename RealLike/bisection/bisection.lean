import RealLike

open RealLike

/-- Result of a bisection search. -/
inductive BisectionResult (α : Type) where
  | success (root : α) (iterations : Nat)
  | invalidBounds (reason : String)
  | noSignChange (reason : String)
  | maxIterationsReached (bestApprox : α) (iterations : Nat)
  deriving Repr

/-- Configuration parameters for bisection. -/
structure BisectionParams (α : Type) where
  tolerance : α
  maxIterations : Nat := 1000
  deriving Repr

namespace Bisection

variable {α : Type} [RealLike α]

/-- Midpoint of an interval. -/
def midpoint (left right : α) : α := (left + right) / 2

/-- True when `x` is approximately zero under the configured tolerance. -/
def isZeroApprox (params : BisectionParams α) (x : α) : Bool :=
  RealLike.lt (RealLike.abs x) params.tolerance

/-- True when the two values have opposite signs. -/
def oppositeSigns (x y : α) : Bool :=
  (RealLike.isPositive x && RealLike.isNegative y) ||
    (RealLike.isNegative x && RealLike.isPositive y)

/-- Choose the half-interval whose endpoints still have opposite signs. -/
def nextInterval (f : α → α) (left right : α) : α × α :=
  let mid := midpoint left right
  if oppositeSigns (f left) (f mid) then
    (left, mid)
  else
    (mid, right)

/-- Contractive bisection loop once initial bounds have been validated. -/
def loop (f : α → α) (params : BisectionParams α) (left right : α) (iter : Nat) :
    BisectionResult α :=
  if iter >= params.maxIterations then
    .maxIterationsReached (midpoint left right) iter
  else
    let mid := midpoint left right
    let fmid := f mid
    let width := right - left
    if RealLike.lt (RealLike.abs fmid) params.tolerance ||
        RealLike.lt width params.tolerance then
      .success mid (iter + 1)
    else
      let next := nextInterval f left right
      loop f params next.1 next.2 (iter + 1)
termination_by params.maxIterations - iter
decreasing_by
  omega

/-- Generic bisection over any `RealLike` type. -/
def bisectionCore (f : α → α) (a b : α) (params : BisectionParams α) :
    BisectionResult α :=
  if RealLike.le b a then
    .invalidBounds "left bound must be less than right bound"
  else if !(oppositeSigns (f a) (f b)) then
    .noSignChange "function must have opposite signs at bounds"
  else
    loop f params a b 0

end Bisection

open Bisection

def defaultParamsFloat : BisectionParams Float :=
  { tolerance := 1e-10, maxIterations := 1000 }

noncomputable def defaultParamsReal : BisectionParams ℝ :=
  { tolerance := 1 / 1000000, maxIterations := 100 }

/-- Convenience wrapper for executable `Float` root finding. -/
def findRoot (f : Float → Float) (a b : Float) : BisectionResult Float :=
  Bisection.bisectionCore f a b defaultParamsFloat
