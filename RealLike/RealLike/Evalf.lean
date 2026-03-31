import RealLike.Pipeline
import RealLike.Repr

open Lean Lean.Elab Lean.Elab.Command Lean.Elab.Term Lean.Meta

namespace RealLike

namespace Meta

def isRealLikeFunction (constName : Name) : Lean.MetaM Bool := do
  let ci ← getConstInfo constName
  pure <| ci.type.containsConst (· == ``RealLike)

def baseEvalfExpr (constName : Name) : Lean.MetaM Expr := do
  if (← isRealLikeFunction constName) then
    let ci ← getConstInfo constName
    let floatExpr := Lean.mkConst ``Float
    let instType := mkApp (Lean.mkConst ``RealLike) floatExpr
    let instExpr ← synthInstance instType
    pure <| mkAppN (Lean.mkConst constName (ci.levelParams.map Level.param)) #[floatExpr, instExpr]
  else
    let floatN ← Lean.Elab.Term.TermElabM.run' do
      getOrCreateFloat constName
    let ci ← getConstInfo floatN
    pure <| Lean.mkConst floatN (ci.levelParams.map Level.param)

def constAtTypeLevel (name : Name) (dom : Expr) : Lean.MetaM Expr := do
  let domType ← inferType dom
  match domType with
  | .sort (.succ u) =>
      pure <| Lean.mkConst name [u]
  | .sort u =>
      pure <| Lean.mkConst name [u]
  | _ =>
      mkConstWithFreshMVarLevels name

def constAtSortLevel (name : Name) (dom : Expr) : Lean.MetaM Expr := do
  let domType ← inferType dom
  match domType with
  | .sort u =>
      pure <| Lean.mkConst name [u]
  | _ =>
      mkConstWithFreshMVarLevels name

def evalfValidateInst? (dom : Expr) : Lean.MetaM (Option (Expr × Expr)) := do
  let dom ← instantiateMVars dom
  let dom ← whnf dom
  let validateType := mkApp (← constAtTypeLevel ``RealLike.EvalfValidate dom) dom
  let inhabitedType := mkApp (← constAtSortLevel ``Inhabited dom) dom
  let validateInst ← try
    pure <| some (← synthInstance validateType)
  catch _ =>
    pure none
  let inhabitedInst ← try
    pure <| some (← synthInstance inhabitedType)
  catch _ =>
    pure none
  match validateInst, inhabitedInst with
  | some validateInst, some inhabitedInst =>
      pure <| some (validateInst, inhabitedInst)
  | _, _ =>
      pure none

def coerceEvalfArgCore (unchecked : Bool) (arg : Expr) (dom : Expr) : Lean.MetaM Expr := do
  let dom ← instantiateMVars dom
  let dom ← whnf dom
  let argType ← instantiateMVars (← inferType arg)
  let argType ← whnf argType
  let argFitsDom ← isDefEq argType dom
  if argFitsDom then
    return arg
  match ← evalfValidateInst? dom with
  | none =>
      throwError "argument type mismatch for `#evalf`: expected {dom}, got {argType}"
  | some (validateInst, inhabitedInst) =>
      let rawType := mkAppN (← constAtTypeLevel ``RealLike.EvalfValidate.Raw dom)
        #[dom, validateInst]
      let rawType ← instantiateMVars rawType
      let rawType ← whnf rawType
      if ← isDefEq argType rawType then
        if unchecked then
          pure <| mkAppN (← constAtTypeLevel ``RealLike.unsafeUncheckedFromRaw dom)
            #[dom, validateInst, arg]
        else
          pure <| mkAppN (← constAtTypeLevel ``RealLike.unsafeFromRaw dom)
            #[dom, validateInst, inhabitedInst, arg]
      else
        throwError
          "argument type mismatch for `#evalf`: \
          expected {dom} or raw input {rawType}, got {argType}"

def applyEvalfExprArgsCore (unchecked : Bool) (fnExpr : Expr) (args : Array Expr) :
    Lean.MetaM Expr := do
  let fnType ← inferType fnExpr
  forallTelescopeReducing fnType fun xs _ => do
    let mut explicitIdx := 0
    let mut appArgs := #[]
    for x in xs do
      if explicitIdx < args.size then
        let localDecl ← x.fvarId!.getDecl
        if localDecl.binderInfo.isExplicit then
          let argExpr ← coerceEvalfArgCore unchecked args[explicitIdx]! localDecl.type
          appArgs := appArgs.push argExpr
          explicitIdx := explicitIdx + 1
        else if localDecl.binderInfo.isInstImplicit then
          let instExpr ← try
              synthInstance localDecl.type
            catch _ =>
              mkFreshExprMVar localDecl.type
          appArgs := appArgs.push instExpr
        else
          appArgs := appArgs.push (← mkFreshExprMVar localDecl.type)
      else
        break
    if explicitIdx < args.size then
      throwError "too many arguments for `#evalf`"
    instantiateMVars <| mkAppN fnExpr appArgs

def applyEvalfExprArgs (fnExpr : Expr) (args : Array Expr) : Lean.MetaM Expr :=
  applyEvalfExprArgsCore false fnExpr args

def applyUnsafeEvalfExprArgs (fnExpr : Expr) (args : Array Expr) : Lean.MetaM Expr :=
  applyEvalfExprArgsCore true fnExpr args

def mkEvalfExprCore (unchecked : Bool) (value : Expr) : Lean.MetaM Expr := do
  let value ← instantiateMVars value
  let (constName, args) := value.getAppFnArgs
  let baseExpr ← baseEvalfExpr constName
  if unchecked then
    applyUnsafeEvalfExprArgs baseExpr args
  else
    applyEvalfExprArgs baseExpr args

def mkEvalfExpr (value : Expr) : Lean.MetaM Expr :=
  mkEvalfExprCore false value

def mkUnsafeEvalfExpr (value : Expr) : Lean.MetaM Expr :=
  mkEvalfExprCore true value

unsafe def evalfExpr (α : Type) (expectedType : Expr) (value : Expr) : Lean.MetaM α := do
  let lowered ← mkEvalfExpr value
  Lean.Meta.evalExpr α expectedType lowered (safety := .unsafe)

unsafe def unsafeEvalfExpr (α : Type) (expectedType : Expr) (value : Expr) : Lean.MetaM α := do
  let lowered ← mkUnsafeEvalfExpr value
  Lean.Meta.evalExpr α expectedType lowered (safety := .unsafe)

end Meta

def baseEvalfExpr (constName : Name) : TermElabM Expr := do
  liftMetaM <| Meta.baseEvalfExpr constName

def elabEvalfArgCore (unchecked : Bool) (arg : Syntax) (dom : Expr) : TermElabM Expr := do
  let dom ← instantiateMVars dom
  let dom ← whnf dom
  match ← liftMetaM <| Meta.evalfValidateInst? dom with
  | none =>
      elabTerm arg (some dom)
  | some (validateInst, inhabitedInst) =>
      let rawType := mkAppN (← liftMetaM <| Meta.constAtTypeLevel ``RealLike.EvalfValidate.Raw dom)
        #[dom, validateInst]
      let rawType ← instantiateMVars rawType
      let rawType ← whnf rawType
      let sameType ← liftMetaM <| isDefEq rawType dom
      if sameType then
        elabTerm arg (some dom)
      else
        try
          let rawArg ← elabTerm arg (some rawType)
          if unchecked then
            pure <| mkAppN
              (← liftMetaM <| Meta.constAtTypeLevel ``RealLike.unsafeUncheckedFromRaw dom)
              #[dom, validateInst, rawArg]
          else
            pure <| mkAppN (← liftMetaM <| Meta.constAtTypeLevel ``RealLike.unsafeFromRaw dom)
              #[dom, validateInst, inhabitedInst, rawArg]
        catch _ =>
          elabTerm arg (some dom)

def elabEvalfArg (arg : Syntax) (dom : Expr) : TermElabM Expr :=
  elabEvalfArgCore false arg dom

def elabUnsafeEvalfArg (arg : Syntax) (dom : Expr) : TermElabM Expr :=
  elabEvalfArgCore true arg dom

def elabEvalfArgsCore (unchecked : Bool) (fnType : Expr) (args : Array Syntax) :
    TermElabM (Array Expr) := do
  forallTelescopeReducing fnType fun xs _ => do
    let mut explicitIdx := 0
    let mut explicitArgs := #[]
    for x in xs do
      if explicitIdx < args.size then
        let localDecl ← x.fvarId!.getDecl
        if localDecl.binderInfo.isExplicit then
          let argExpr ← elabEvalfArgCore unchecked args[explicitIdx]! localDecl.type
          explicitArgs := explicitArgs.push argExpr
          explicitIdx := explicitIdx + 1
      else
        break
    if explicitIdx < args.size then
      throwError "too many arguments for `#evalf`"
    pure explicitArgs

def applyEvalfArgs (fnExpr : Expr) (args : Array Syntax) : TermElabM Expr := do
  let fnType ← liftMetaM <| inferType fnExpr
  let argExprs ← elabEvalfArgsCore false fnType args
  liftMetaM <| Meta.applyEvalfExprArgs fnExpr argExprs

def applyUnsafeEvalfArgs (fnExpr : Expr) (args : Array Syntax) : TermElabM Expr := do
  let fnType ← liftMetaM <| inferType fnExpr
  let argExprs ← elabEvalfArgsCore true fnType args
  liftMetaM <| Meta.applyUnsafeEvalfExprArgs fnExpr argExprs

private def elabEvalfTermCore (unchecked : Bool) (fn : Syntax) (args : Array Syntax) :
    TermElabM Expr := do
  let constName ← resolveGlobalConstNoOverload fn
  let baseExpr ← baseEvalfExpr constName
  let finalExpr ←
    if unchecked then
      applyUnsafeEvalfArgs baseExpr args
    else
      applyEvalfArgs baseExpr args
  instantiateMVars finalExpr

elab "evalf%" fn:ident args:(ppSpace term:arg)* : term => do
  elabEvalfTermCore false fn args

elab "unsafe_evalf%" fn:ident args:(ppSpace term:arg)* : term => do
  elabEvalfTermCore true fn args

end RealLike

open RealLike in
elab "#evalf" fn:ident args:(ppSpace term:arg)* : command => do
  elabCommand (← `(#eval (evalf% $fn $args*)))

open RealLike in
elab "unsafe_evalf" fn:ident args:(ppSpace term:arg)* : command => do
  elabCommand (← `(#eval (unsafe_evalf% $fn $args*)))
