import RealLike.Class

namespace RealLike

variable {α : Type} [RealLike α]

/-- Base-2 exponential: `2^x`. Uses `RealLike.pow`. -/
def exp2 (x : α) : α := pow 2 x

/-- Base-2 logarithm. Uses `log x / log 2`. -/
def log2 (x : α) : α := log x / log 2

/-- Base-10 logarithm. Uses `log x / log 10`. -/
def log10 (x : α) : α := log x / log 10

/-- Sign predicate using the Bool-returning `lt`. -/
def isPositive (x : α) : Bool := lt zero x

/-- Sign predicate using the Bool-returning `lt`. -/
def isNegative (x : α) : Bool := lt x zero

end RealLike
