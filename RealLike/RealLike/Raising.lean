import RealLike.Lowering
import RealLike.Instances

open Lean Lean.Meta Lean.Elab

namespace RealLike

private def mkRealLikeRealInstance : MetaM Expr := do
  let instType := mkApp (mkConst ``RealLike) (mkConst ``Real)
  synthInstance instType

def realName (constName : Name) : Name :=
  .str (.str `_evalf constName.toString) "_real"

def specializeToReal (constName : Name) : MetaM Name := do
  let realN := realName constName
  if (← getEnv).find? realN |>.isSome then
    return realN

  let genName := genericName constName
  let genCI ← match (← getEnv).find? genName with
    | some (.defnInfo ci) => pure ci
    | some _ => throwError "generic '{genName}' must be a definition"
    | none => throwError "generic '{genName}' not found... run realToGeneric "

  let realExpr := mkConst ``Real
  let instExpr ← mkRealLikeRealInstance
  let genConst := mkConst genName (genCI.levelParams.map Level.param)
  let specialized ← instantiateMVars <| mkAppN genConst #[realExpr, instExpr]
  let realType ← instantiateMVars (← inferType specialized)

  let decl : Declaration := .defnDecl {
    name := realN
    levelParams := []
    type := realType
    value := specialized
    hints := .abbrev
    safety := .safe
  }
  addDecl decl
  compileDecl decl
  return realN


def getOrCreateReal (constName : Name) : TermElabM Name := do
  if (← getEnv).find? (genericName constName) |>.isNone then
    let _ ← realToGeneric constName
  liftMetaM (specializeToReal constName)

end RealLike
