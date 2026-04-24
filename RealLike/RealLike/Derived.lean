import RealLike.Class

namespace RealLike

variable {α : Type} [RealLike α]
def exp2 (x : α) : α := pow 2 x
def log2 (x : α) : α := log x / log 2
def log10 (x : α) : α := log x / log 10
def isPositive (x : α) : Bool := lt zero x
def isNegative (x : α) : Bool := lt x zero

end RealLike
