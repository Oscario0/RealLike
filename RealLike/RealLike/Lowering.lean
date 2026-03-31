import RealLike.Repr

open Lean Lean.Meta Lean.Elab Lean.Elab.Term

namespace RealLike

private def withDimName : Name := .str .anonymous "WithDim"
private def withDimValName : Name := .str withDimName "val"
private def withDimMkName : Name := .str withDimName "mk"
private def withDimCastName : Name := .str withDimName "cast"

/-- Hidden name for the generic (∀ {α} [RealLike α]) version of a Real function. -/
def genericName (constName : Name) : Name :=
  .str (.str `_evalf constName.toString) "_generic"

/-- Hidden name for the Float-specialized version. -/
def floatName (constName : Name) : Name :=
  .str (.str `_evalf constName.toString) "_float"

private structure SingleFieldWrapperInfo where
  typeName : Name
  ctorName : Name
  projName : Name
  numParams : Nat

private def singleFieldWrapper? (env : Environment) (n : Name) :
    Option SingleFieldWrapperInfo := Id.run do
  let some info := Lean.getStructureInfo? env n | return none
  if info.fieldNames.size != 1 then
    return none
  let ctorInfo := Lean.getStructureCtor env n
  if ctorInfo.numFields != 1 then
    return none
  let fieldName := info.fieldNames[0]!
  let some fieldInfo := Lean.getFieldInfo? env n fieldName | return none
  let some projInfo := env.find? fieldInfo.projFn | return none
  if !(projInfo.type.containsConst (· == ``Real) ||
      projInfo.type.containsConst (· == ``NNReal) ||
      projInfo.type.containsConst (· == ``Subtype) ||
      n == withDimName) then
    return none
  return some {
    typeName := n
    ctorName := ctorInfo.name
    projName := fieldInfo.projFn
    numParams := ctorInfo.numParams
  }

private def mkNonnegativeSubtypeType (α inst : Expr) : MetaM Expr := do
  pure <| mkAppN (mkConst ``RealLike.Nonnegative) #[α, inst]

private def rewriteProofPredicate (e α inst : Expr) : MetaM Expr := do
  transform e
    (post := fun e => do
      match e with
      | .const ``Real _ =>
          return .done α
      | .app .. =>
          let fn := e.getAppFn
          let args := e.getAppArgs
          match fn with
          | .const n _ =>
              match n, args.size with
              | ``HAdd.hAdd, _ =>
                  if 2 ≤ args.size then
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    return .done <| mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, rhs]
                  else
                    return .done e
              | ``HMul.hMul, _ =>
                  if 2 ≤ args.size then
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    return .done <| mkAppN (mkConst ``RealLike.mul) #[α, inst, lhs, rhs]
                  else
                    return .done e
              | ``HDiv.hDiv, _ =>
                  if 2 ≤ args.size then
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    return .done <| mkAppN (mkConst ``RealLike.div) #[α, inst, lhs, rhs]
                  else
                    return .done e
              | ``Neg.neg, _ =>
                  if 1 ≤ args.size then
                    let x := args[args.size - 1]!
                    return .done <| mkAppN (mkConst ``RealLike.neg) #[α, inst, x]
                  else
                    return .done e
              | ``Sub.sub, _ | ``HSub.hSub, _ =>
                  if 2 ≤ args.size then
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    return .done <|
                      mkAppN (mkConst ``RealLike.add)
                        #[α, inst, lhs, mkAppN (mkConst ``RealLike.neg) #[α, inst, rhs]]
                  else
                    return .done e
              | ``OfNat.ofNat, _ =>
                  if 3 ≤ args.size then do
                    let typeArg := args[0]!
                    let natExpr := args[args.size - 2]!
                    if ← isDefEq typeArg α then
                      return .done (← mkAppOptM ``OfNat.ofNat #[some α, some natExpr, none])
                    else
                      return .done e
                  else
                    return .done e
              | ``LT.lt, _ =>
                  if 2 ≤ args.size then do
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    let p ← mkEq (mkAppN (mkConst ``RealLike.lt) #[α, inst, lhs, rhs]) (toExpr true)
                    return .done p
                  else
                    return .done e
              | ``LE.le, _ =>
                  if 2 ≤ args.size then do
                    let lhs := args[args.size - 2]!
                    let rhs := args[args.size - 1]!
                    let p ← mkEq (mkAppN (mkConst ``RealLike.le) #[α, inst, lhs, rhs]) (toExpr true)
                    return .done p
                  else
                    return .done e
              | _, _ =>
                  return .done e
          | _ =>
              return .done e
      | _ =>
          return .done e)
    (skipConstInApp := true)

private def rewriteProofScalarType? (e α inst : Expr) (proofScalarsToPayload : Bool) :
    MetaM (Option Expr) := do
  let eWhnf ← whnf e
  match eWhnf with
  | .const ``NNReal _ =>
      if proofScalarsToPayload then
        return some α
      else
        return some (← mkNonnegativeSubtypeType α inst)
  | .app .. =>
      let fn := eWhnf.getAppFn
      let args := eWhnf.getAppArgs
      match fn with
      | .const ``Subtype _ =>
          if args.size == 2 then
            let base := args[0]!
            let pred := args[1]!
            if ← isDefEq base (mkConst ``Real) then
              if proofScalarsToPayload then
                return some α
              else
                withLocalDecl `x .default α fun x => do
                  let predBody ← rewriteProofPredicate (mkApp pred x) α inst
                  let predLam ← mkLambdaFVars #[x] predBody
                  return some <| (← mkAppOptM ``Subtype #[some α, some predLam])
            else
              return none
          else
            return none
      | _ =>
          return none
  | _ =>
      return none

private def rewriteWrapperTypeApp? (env : Environment) (e α inst : Expr)
    (proofScalarsToPayload : Bool) :
    MetaM (Option Expr) := do
  let fn := e.getAppFn
  let args := e.getAppArgs
  let .const n us := fn | return none
  if n == withDimName && args.size == 2 then
    return some args[1]!
  let some info := singleFieldWrapper? env n | return none
  if args.size != info.numParams then
    return none
  let self ← mkFreshExprMVar e
  let projType ← inferType <| mkAppN (.const info.projName us) (args.push self)
  let fieldType ← transform projType
    (post := fun e => do
      match e with
      | .const ``Real _ =>
          return .done α
      | .const ``NNReal _ =>
          if proofScalarsToPayload then
            return .done α
          else
            return .done (← mkNonnegativeSubtypeType α inst)
      | .app .. =>
          match (← rewriteProofScalarType? e α inst proofScalarsToPayload) with
          | some e' =>
              return .done e'
          | none =>
              return .done e
      | _ =>
          return .done e)
    (skipConstInApp := true)
  if fieldType == projType then
    return none
  return some fieldType

private def rewriteScalarType (env : Environment) (n : Name) (α inst : Expr)
    (proofScalarsToPayload : Bool) :
    MetaM (Option Expr) := do
  if n == ``Real then
    return some α
  if n == ``NNReal then
    if proofScalarsToPayload then
      return some α
    else
      return some (← mkNonnegativeSubtypeType α inst)
  if let some fieldType ← rewriteWrapperTypeApp? env (.const n []) α inst proofScalarsToPayload then
    return some fieldType
  return none

private def rewriteWrapperProjection (env : Environment) (structName : Name) (idx : Nat)
    (arg : Expr) : MetaM (Option Expr) := do
  let some info := singleFieldWrapper? env structName | return none
  if idx == 0 && info.typeName == structName then
    return some arg
  return none

private def nameFromDottedString (s : String) : Name :=
  s.splitOn "." |>.foldl (init := .anonymous) fun n part => .str n part

private def singleFieldWrapperByProj? (env : Environment) (projName : Name) :
    Option SingleFieldWrapperInfo := Id.run do
  if let some info := singleFieldWrapper? env projName.getPrefix then
    if info.projName == projName then
      return some info
  let parts := projName.toString.splitOn "."
  if 1 < parts.length then
    let structName := nameFromDottedString <| String.intercalate "." (parts.dropLast)
    if let some info := singleFieldWrapper? env structName then
      if info.projName == projName then
        return some info
  return none

private def rewriteWrapperProjectionApp (env : Environment) (n : Name)
    (args : Array Expr) : Option Expr :=
  match singleFieldWrapperByProj? env n with
  | none => none
  | some info =>
      if h : info.numParams < args.size then
        let payload := args[info.numParams]
        let tail := args.extract (info.numParams + 1) args.size
        some <| mkAppN payload tail
      else
        none

private def rewriteWrapperCtor (env : Environment) (n : Name) (args : Array Expr) :
    MetaM (Option Expr) := do
  for structName in [n.getPrefix] do
    let some info := singleFieldWrapper? env structName | continue
    if info.ctorName == n && args.size == info.numParams + 1 then
      return some args[args.size - 1]!
  return none

private def projectSubtypeVal (arg : Expr) : MetaM Expr :=
  mkAppOptM ``Subtype.val #[none, none, some arg]

private def eraseProofScalarArg (arg α inst : Expr) : MetaM Expr := do
  let argType ← whnf (← inferType arg)
  match argType with
  | .const ``NNReal _ =>
      projectSubtypeVal arg
  | .app .. =>
      let fn := argType.getAppFn
      let args := argType.getAppArgs
      match fn with
      | .const ``Subtype _ =>
          if args.size == 2 then
            projectSubtypeVal arg
          else
            pure arg
      | _ =>
          match (← rewriteProofScalarType? argType α inst false) with
          | some _ =>
              projectSubtypeVal arg
          | none =>
              pure arg
  | _ =>
      match (← rewriteProofScalarType? argType α inst false) with
      | some _ =>
          projectSubtypeVal arg
      | none =>
          pure arg

private def isSingleFieldWrapperProjection (env : Environment) (n : Name) : Bool :=
  (singleFieldWrapperByProj? env n).isSome

private def mapRealToRealLike : Name → Option Name
  | `Real.sqrt   => some `RealLike.sqrt
  | `Real.pi     => some `RealLike.pi
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
  if (mapRealToRealLike n).isSome || n == ``Real || n == ``NNReal.toReal ||
      n == ``Subtype.val || isSingleFieldWrapperProjection env n then
    false
  else
    match env.find? n with
    | some (.defnInfo ci) =>
        ci.type.containsConst (· == ``Real) &&
          !n.isInternal &&
          !n.toString.contains "Mathlib" &&
          !(n.components.any fun c => c.toString.startsWith "inst")
    | _ => false

private def collectRealFunctionsAux
    (env : Environment) (e : Expr) (seen : Std.HashSet Name) : Std.HashSet Name :=
  match e with
  | .const n _ =>
      if shouldGeneralize env n then seen.insert n else seen
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
termination_by e

private def collectRealFunctions (env : Environment) (e : Expr) : Array Name :=
  (collectRealFunctionsAux env e {}).toArray.qsort Name.quickLt

private def rewriteOverloadedApp (fn : Name) (args : Array Expr) (α inst : Expr) :
    MetaM (Option Expr) :=
  match fn, args.size with
  | ``HAdd.hAdd, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, rhs]
      else pure none
  | ``HMul.hMul, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.mul) #[α, inst, lhs, rhs]
      else pure none
  | ``HDiv.hDiv, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.div) #[α, inst, lhs, rhs]
      else pure none
  | ``Neg.neg, _ =>
      if 1 ≤ args.size then do
        let x ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.neg) #[α, inst, x]
      else pure none
  | ``Sub.sub, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        let negRhs := mkAppN (mkConst ``RealLike.neg) #[α, inst, rhs]
        pure <| some <| mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, negRhs]
      else pure none
  | ``HSub.hSub, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        let negRhs := mkAppN (mkConst ``RealLike.neg) #[α, inst, rhs]
        pure <| some <| mkAppN (mkConst ``RealLike.add) #[α, inst, lhs, negRhs]
      else pure none
  | ``HPow.hPow, _ =>
      if 2 ≤ args.size then do
        let base ← eraseProofScalarArg args[args.size - 2]! α inst
        let exp ← eraseProofScalarArg args[args.size - 1]! α inst
        let expTy ← inferType exp
        if expTy.isConstOf ``Nat then
          let hPowInst ← synthInstance (mkAppN (mkConst ``HPow) #[α, mkConst ``Nat, α])
          pure <| some <|
            mkAppN (mkConst ``HPow.hPow) #[α, mkConst ``Nat, α, hPowInst, base, exp]
        else
          pure <| some <| mkAppN (mkConst ``RealLike.pow) #[α, inst, base, exp]
      else pure none
  | ``OfNat.ofNat, _ =>
      if 3 ≤ args.size then do
        let typeArg := args[0]!
        let natExpr := args[args.size - 2]!
        if ← isDefEq typeArg α then
          pure <| some <| (← mkAppOptM ``OfNat.ofNat #[some α, some natExpr, none])
        else
          pure none
      else pure none
  | ``OfScientific.ofScientific, _ =>
      if 5 ≤ args.size then do
        let typeArg := args[0]!
        let mantissa := args[args.size - 3]!
        let exponentSign := args[args.size - 2]!
        let decimalExponent := args[args.size - 1]!
        if (← isDefEq typeArg α) || typeArg.isConstOf ``Real then
          let instSci ← synthInstance (← mkAppM ``OfScientific #[α])
          pure <| some <| (← mkAppOptM ``OfScientific.ofScientific
            #[some α, some instSci, some mantissa, some exponentSign, some decimalExponent])
        else
          pure none
      else pure none
  | ``_root_.round, _ =>
      if 1 ≤ args.size then do
        let x ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.round) #[α, inst, x]
      else pure none
  | ``Int.floor, _ =>
      if 1 ≤ args.size then do
        let x ← eraseProofScalarArg args[args.size - 1]! α inst
        pure <| some <| mkAppN (mkConst ``RealLike.floor) #[α, inst, x]
      else pure none
  | ``Int.ceil, _ =>
      if 1 ≤ args.size then do
        let x ← eraseProofScalarArg args[args.size - 1]! α inst
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
                let arg := roundArgs[roundArgs.size - 1]!
                pure <| some <| mkAppN (mkConst ``RealLike.round) #[α, inst, arg]
              else
                pure none
          | .const ``Int.floor _ =>
              let floorArgs := x.getAppArgs
              if 1 ≤ floorArgs.size then
                let arg := floorArgs[floorArgs.size - 1]!
                pure <| some <| mkAppN (mkConst ``RealLike.floor) #[α, inst, arg]
              else
                pure none
          | .const ``Int.ceil _ =>
              let ceilArgs := x.getAppArgs
              if 1 ≤ ceilArgs.size then
                let arg := ceilArgs[ceilArgs.size - 1]!
                pure <| some <| mkAppN (mkConst ``RealLike.ceil) #[α, inst, arg]
              else
                pure none
          | _ =>
              pure none
      else pure none
  | ``LT.lt, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        let p ← mkEq (mkAppN (mkConst ``RealLike.lt) #[α, inst, lhs, rhs]) (toExpr true)
        pure <| some p
      else pure none
  | ``LE.le, _ =>
      if 2 ≤ args.size then do
        let lhs ← eraseProofScalarArg args[args.size - 2]! α inst
        let rhs ← eraseProofScalarArg args[args.size - 1]! α inst
        let p ← mkEq (mkAppN (mkConst ``RealLike.le) #[α, inst, lhs, rhs]) (toExpr true)
        pure <| some p
      else pure none
  | _ , _ => pure none

private def rewriteTypeForGeneric (e α inst : Expr) (proofScalarsToPayload : Bool) :
    MetaM Expr := do
  let env ← getEnv
  if let some e' ← rewriteProofScalarType? e α inst proofScalarsToPayload then
    return e'
  let rewritten ← transform e
    (post := fun e => do
      match e with
      | .const n _ =>
          match (← rewriteScalarType env n α inst proofScalarsToPayload) with
          | some e' =>
              return .done e'
          | none =>
              return .done e
      | .app .. =>
          match (← rewriteProofScalarType? e α inst proofScalarsToPayload) with
          | some e' =>
              return .done e'
          | none =>
              match (← rewriteWrapperTypeApp? env e α inst proofScalarsToPayload) with
              | some e' =>
                  return .done e'
              | none =>
                  return .done e
      | _ =>
          return .done e)
    (skipConstInApp := true)
  match rewritten with
  | .const n _ =>
      match (← rewriteScalarType env n α inst proofScalarsToPayload) with
      | some e' => pure e'
      | none => pure rewritten
  | .app .. =>
      match (← rewriteProofScalarType? rewritten α inst proofScalarsToPayload) with
      | some e' => pure e'
      | none =>
          match (← rewriteWrapperTypeApp? env rewritten α inst proofScalarsToPayload) with
          | some e' => pure e'
          | none => pure rewritten
  | _ => pure rewritten

private def rewriteDomainTypeForGeneric (e α inst : Expr) : MetaM Expr :=
  rewriteTypeForGeneric e α inst false

private def rewriteResultTypeForGeneric (e α inst : Expr) : MetaM Expr :=
  rewriteTypeForGeneric e α inst true

private partial def rewriteSignatureTypeForGeneric (e α inst : Expr) : MetaM Expr := do
  match e with
  | .forallE n dom body bi =>
      let dom' ← rewriteDomainTypeForGeneric dom α inst
      withLocalDecl n bi dom' fun x => do
        let body' ← rewriteSignatureTypeForGeneric (body.instantiate1 x) α inst
        mkForallFVars #[x] body'
  | _ =>
      rewriteResultTypeForGeneric e α inst

private partial def rewriteForGeneric (e α inst : Expr) : MetaM Expr := do
  match e with
  | .lam n dom body bi =>
      let dom' ← rewriteDomainTypeForGeneric dom α inst
      withLocalDecl n bi dom' fun x => do
        let body' ← rewriteForGeneric (body.instantiate1 x) α inst
        mkLambdaFVars #[x] body'
  | .forallE n dom body bi =>
      let dom' ← rewriteDomainTypeForGeneric dom α inst
      withLocalDecl n bi dom' fun x => do
        let body' ← rewriteForGeneric (body.instantiate1 x) α inst
        mkForallFVars #[x] body'
  | .letE n type value body nonDep =>
      return .letE n (← rewriteResultTypeForGeneric type α inst)
        (← rewriteForGeneric value α inst) (← rewriteForGeneric body α inst) nonDep
  | _ =>
      let env ← getEnv
      let rewritten ← transform e
        (post := fun e => do
          match e with
          | .proj structName idx b =>
              match (← rewriteWrapperProjection env structName idx b) with
              | some e' =>
                  return .done e'
              | none =>
                  return .done e
          | .const n us =>
              match (← rewriteScalarType env n α inst true) with
              | some e' =>
                  return .done e'
              | none =>
                  match mapRealToRealLike n with
                  | some n' =>
                      return .done <| mkAppN (mkConst n') #[α, inst]
                  | none =>
                      if shouldGeneralize env n then
                        return .done <| mkAppN (.const (genericName n) us) #[α, inst]
                      else
                        return .done e
          | .app .. =>
              let fn := e.getAppFn
              let args := e.getAppArgs
              match fn with
              | .const n us =>
                  if n == withDimValName && 3 ≤ args.size then
                    let payload := args[2]!
                    let tail := args.extract 3 args.size
                    return .done <| mkAppN payload tail
                  if n == withDimMkName && 1 ≤ args.size then
                    return .done args[args.size - 1]!
                  if n == withDimCastName && 2 ≤ args.size then
                    return .done args[args.size - 2]!
                  if n == ``NNReal.toReal && 1 ≤ args.size then
                    return .done <| (← eraseProofScalarArg args[args.size - 1]! α inst)
                  if n == ``Subtype.val && 1 ≤ args.size then
                    return .done <| (← eraseProofScalarArg args[args.size - 1]! α inst)
                  if n == ``Subtype.mk && 4 ≤ args.size then
                    return .done args[args.size - 2]!
                  match rewriteWrapperProjectionApp env n args with
                  | some e' =>
                      return .done e'
                  | none =>
                      match (← rewriteWrapperCtor env n args) with
                      | some e' =>
                          return .done e'
                      | none =>
                          match mapRealToRealLike n with
                          | some n' =>
                              return .done <| mkAppN (mkAppN (.const n' us) #[α, inst]) args
                          | none =>
                              match (← rewriteOverloadedApp n args α inst) with
                              | some e' =>
                                  return .done e'
                              | none =>
                                  if shouldGeneralize env n then
                                    let genFn := mkAppN (.const (genericName n) us) #[α, inst]
                                    return .done <| mkAppN genFn args
                                  else
                                    return .done e
              | _ =>
                  return .done e
          | _ =>
              return .done e)
        (skipConstInApp := true)
      match rewritten with
      | .proj structName idx b =>
          match (← rewriteWrapperProjection env structName idx b) with
          | some e' => pure e'
          | none => pure rewritten
      | .const n us =>
          match (← rewriteScalarType env n α inst true) with
          | some e' => pure e'
          | none =>
              match mapRealToRealLike n with
              | some n' => pure <| mkAppN (mkConst n' us) #[α, inst]
              | none =>
                  if shouldGeneralize env n then
                    pure <| mkAppN (.const (genericName n) us) #[α, inst]
                  else
                    pure rewritten
      | .app .. =>
          let fn := rewritten.getAppFn
          let args := rewritten.getAppArgs
          match fn with
          | .const n _ =>
              if n == withDimValName && 3 ≤ args.size then
                let payload := args[2]!
                let tail := args.extract 3 args.size
                pure <| mkAppN payload tail
              else if n == withDimMkName && 1 ≤ args.size then
                pure args[args.size - 1]!
              else if n == withDimCastName && 2 ≤ args.size then
                pure args[args.size - 2]!
              else if n == ``NNReal.toReal && 1 ≤ args.size then
                eraseProofScalarArg args[args.size - 1]! α inst
              else if n == ``Subtype.val && 1 ≤ args.size then
                eraseProofScalarArg args[args.size - 1]! α inst
              else
                match rewriteWrapperProjectionApp env n args with
                | some e' => pure e'
                | none =>
                    match (← rewriteWrapperCtor env n args) with
                    | some e' => pure e'
                    | none => pure rewritten
          | _ => pure rewritten
      | _ => pure rewritten

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
      let genericType ← rewriteSignatureTypeForGeneric ci.type αFVar instFVar
      let genericExpr ← instantiateMVars (← mkLambdaFVars #[αFVar, instFVar] genericValue)
      let genericType ← instantiateMVars (← mkForallFVars #[αFVar, instFVar] genericType)
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
