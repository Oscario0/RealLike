import RealLike.Instances

open Lean Lean.Meta Lean.Elab Lean.Elab.Term

namespace RealLike

/-- Hidden name for the generic (∀ {α} [RealLike α]) version of a Real function. -/
def genericName (constName : Name) : Name :=
  .str (.str `_evalf constName.toString) "_generic"

/-- Hidden name for the Float-specialized version. -/
def floatName (constName : Name) : Name :=
  .str (.str `_evalf constName.toString) "_float"

/-- Direct replacement for named `Real.*` functions. -/
private def mapRealToRealLike : Name → Option Name
  | `Real.sqrt   => some `RealLike.sqrt
  | `Real.exp    => some `RealLike.exp
  | `Real.log    => some `RealLike.log
  | `Real.sin    => some `RealLike.sin
  | `Real.cos    => some `RealLike.cos
  | `Real.tan    => some `RealLike.tan
  | `Real.arcsin => some `RealLike.asin
  | `Real.arccos => some `RealLike.acos
  | `Real.arctan => some `RealLike.atan
  | `Real.atan2  => some `RealLike.atan2
  | `Real.sinh   => some `RealLike.sinh
  | `Real.cosh   => some `RealLike.cosh
  | `Real.tanh   => some `RealLike.tanh
  | `Real.rpow   => some `RealLike.pow
  | _            => none

private def shouldGeneralize (env : Environment) (n : Name) : Bool :=
  if (mapRealToRealLike n).isSome || n == ``Real then
    false
  else
    match env.find? n with
    | some (.defnInfo ci) =>
        ci.type.containsConst (· == ``Real) &&
          !n.isInternal &&
          !n.toString.contains "Mathlib" &&
          !(n.components.any fun c => c.toString.startsWith "inst")
    | _ => false

private partial def collectRealFunctionsAux
    (env : Environment) (e : Expr) (seen : Std.HashSet Name) : Std.HashSet Name :=
  match e with
  | .app f a =>
      let seen :=
        match e.getAppFn with
        | .const n _ =>
            if shouldGeneralize env n then seen.insert n else seen
        | _ => seen
      collectRealFunctionsAux env a (collectRealFunctionsAux env f seen)
  | .lam _ d b _ =>
      collectRealFunctionsAux env b (collectRealFunctionsAux env d seen)
  | .forallE _ d b _ =>
      collectRealFunctionsAux env b (collectRealFunctionsAux env d seen)
  | .letE _ t v b _ =>
      collectRealFunctionsAux env b <|
        collectRealFunctionsAux env v <|
          collectRealFunctionsAux env t seen
  | .mdata _ b =>
      collectRealFunctionsAux env b seen
  | .proj _ _ b =>
      collectRealFunctionsAux env b seen
  | _ =>
      seen

/-- Collect referenced user definitions that need recursive lowering. -/
private def collectRealFunctions (env : Environment) (e : Expr) : Array Name :=
  (collectRealFunctionsAux env e {}).toArray.qsort Name.quickLt

private def rewriteOverloadedApp (fn : Name) (args : Array Expr) (α inst : Expr) : MetaM (Option Expr) :=
  match fn, args.size with
  | ``HAdd.hAdd, _ =>
      if 2 ≤ args.size then
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, rhs]
      else pure none
  | ``HMul.hMul, _ =>
      if 2 ≤ args.size then
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.mul) #[α, inst, lhs, rhs]
      else pure none
  | ``HDiv.hDiv, _ =>
      if 2 ≤ args.size then
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.div) #[α, inst, lhs, rhs]
      else pure none
  | ``Neg.neg, _ =>
      if 1 ≤ args.size then
        let x := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.neg) #[α, inst, x]
      else pure none
  | ``Sub.sub, _ =>
      if 2 ≤ args.size then
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        pure <| some <|
          mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, mkAppN (mkConst ``RealLike.neg) #[α, inst, rhs]]
      else pure none
  | ``HSub.hSub, _ =>
      if 2 ≤ args.size then
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        pure <| some <|
          mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, mkAppN (mkConst ``RealLike.neg) #[α, inst, rhs]]
      else pure none
  | ``HPow.hPow, _ =>
      if 2 ≤ args.size then do
        let base := args[args.size - 2]!
        let exp := args[args.size - 1]!
        let expTy ← inferType exp
        if expTy.isConstOf ``Nat then
          let hPowInst ← synthInstance (mkAppN (mkConst ``HPow) #[α, mkConst ``Nat, α])
          pure <| some <|
            mkAppN (mkConst ``HPow.hPow) #[α, mkConst ``Nat, α, hPowInst, base, exp]
        else
          pure <| some <| mkAppN (mkConst ``RealLike.pow) #[α, inst, base, exp]
      else pure none
  | ``OfNat.ofNat, _ =>
      if 2 ≤ args.size then do
        let natExpr := args[args.size - 2]!
        pure <| some <| (← mkAppOptM ``OfNat.ofNat #[some α, some natExpr, none])
      else pure none
  | ``_root_.round, _ =>
      if 1 ≤ args.size then
        let x := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.round) #[α, inst, x]
      else pure none
  | ``Int.floor, _ =>
      if 1 ≤ args.size then
        let x := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.floor) #[α, inst, x]
      else pure none
  | ``Int.ceil, _ =>
      if 1 ≤ args.size then
        let x := args[args.size - 1]!
        pure <| some <| mkAppN (mkConst ``RealLike.ceil) #[α, inst, x]
      else pure none
  | ``Int.cast, _ =>
      if 1 ≤ args.size then do
        let x := args[args.size - 1]!
        let xType ← inferType x
        if ← isDefEq xType α then
          pure <| some x
        else
          match x.getAppFn with
          | .const ``_root_.round _ =>
              let roundArgs := x.getAppArgs
              if 1 ≤ roundArgs.size then
                pure <| some <| mkAppN (mkConst ``RealLike.round) #[α, inst, roundArgs[roundArgs.size - 1]!]
              else
                pure none
          | .const ``Int.floor _ =>
              let floorArgs := x.getAppArgs
              if 1 ≤ floorArgs.size then
                pure <| some <| mkAppN (mkConst ``RealLike.floor) #[α, inst, floorArgs[floorArgs.size - 1]!]
              else
                pure none
          | .const ``Int.ceil _ =>
              let ceilArgs := x.getAppArgs
              if 1 ≤ ceilArgs.size then
                pure <| some <| mkAppN (mkConst ``RealLike.ceil) #[α, inst, ceilArgs[ceilArgs.size - 1]!]
              else
                pure none
          | _ =>
              pure none
      else pure none
  | ``LT.lt, _ =>
      if 2 ≤ args.size then do
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        let p ← mkEq (mkAppN (mkConst ``RealLike.lt) #[α, inst, lhs, rhs]) (toExpr true)
        pure <| some p
      else pure none
  | ``LE.le, _ =>
      if 2 ≤ args.size then do
        let lhs := args[args.size - 2]!
        let rhs := args[args.size - 1]!
        let p ← mkEq (mkAppN (mkConst ``RealLike.le) #[α, inst, lhs, rhs]) (toExpr true)
        pure <| some p
      else pure none
  | _ , _ => pure none

/-- Rewrite an expression for generic elaboration. -/
private def rewriteForGeneric (e α inst : Expr) : MetaM Expr := do
  let env ← getEnv
  transform e
    (post := fun e => do
      if e.isConstOf ``Real then
        return .done α
      match e with
      | .const n _ =>
          match mapRealToRealLike n with
          | some n' =>
              return .done <| mkAppN (mkConst n') #[α, inst]
          | none =>
              return .done e
      | .app .. =>
          let fn := e.getAppFn
          let args := e.getAppArgs
          match fn with
          | .const n us =>
              match mapRealToRealLike n with
              | some n' =>
                  return .done <| mkAppN (mkAppN (.const n' us) #[α, inst]) args
              | none =>
                  match (← rewriteOverloadedApp n args α inst) with
                  | some e' =>
                      return .done e'
                  | none =>
                      if shouldGeneralize env n then
                        return .done <| mkAppN (mkAppN (.const (genericName n) us) #[α, inst]) args
                      else
                        return .done e
          | _ =>
              return .done e
      | _ =>
          return .done e)
    (skipConstInApp := true)

/-- Register a generic `RealLike`-polymorphic version of a concrete `ℝ` definition. -/
partial def realToGeneric (constName : Name) : TermElabM Name := do
  let genName := genericName constName
  if (← getEnv).find? genName |>.isSome then
    return genName
  let ci ← match (← getEnv).find? constName with
    | some (.defnInfo ci) => pure ci
    | some _ => throwError "realToGeneric: '{constName}' must be a definition with a body"
    | none => throwError "realToGeneric: '{constName}' not found in environment"
  let refdFunctions := collectRealFunctions (← getEnv) ci.value
  for fname in refdFunctions do
    if fname != constName then
      let _ ← realToGeneric fname
  let decl ← withLocalDecl `α .implicit (mkSort levelOne) fun αFVar => do
    let instType := mkApp (mkConst ``RealLike) αFVar
    withLocalDecl `inst .instImplicit instType fun instFVar => do
      let genericValue ← rewriteForGeneric ci.value αFVar instFVar
      let genericExpr ← instantiateMVars (← mkLambdaFVars #[αFVar, instFVar] genericValue)
      let genericType ← instantiateMVars (← inferType genericExpr)
      pure <| Declaration.defnDecl {
        name := genName
        levelParams := ci.levelParams
        type := genericType
        value := genericExpr
        hints := ci.hints
        safety := ci.safety
      }
  addDecl decl
  compileDecl decl
  return genName

end RealLike
