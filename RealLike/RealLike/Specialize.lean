import RealLike.Lowering

open Lean Lean.Meta Lean.Elab

namespace RealLike
def specializeToFloat (constName : Name) : MetaM Name := do
  let floatN := floatName constName
  if (← getEnv).find? floatN |>.isSome then
    return floatN

  let genName := genericName constName
  let genCI ← match (← getEnv).find? genName with
    | some (.defnInfo ci) => pure ci
    | some _ => throwError "specializeToFloat: generic '{genName}' must be a definition"
    | none => throwError "specializeToFloat: generic '{genName}' not found; run realToGeneric first"

  let floatExpr := mkConst ``Float
  let instType := mkApp (mkConst ``RealLike) floatExpr
  let instExpr ← synthInstance instType
  let genConst := mkConst genName (genCI.levelParams.map Level.param)
  let specialized ← instantiateMVars <| mkAppN genConst #[floatExpr, instExpr]
  let floatType ← instantiateMVars (← inferType specialized)

  let decl : Declaration := .defnDecl {
    name := floatN
    levelParams := []
    type := floatType
    value := specialized
    hints := .abbrev
    safety := .safe
  }
  addDecl decl
  compileDecl decl
  return floatN

end RealLike
