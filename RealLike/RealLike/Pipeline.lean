import RealLike.Specialize

open Lean Lean.Meta Lean.Elab

namespace RealLike
def getOrCreateFloat (constName : Name) : TermElabM Name := do
  let _ ← realToGeneric constName
  liftMetaM (specializeToFloat constName)

end RealLike
