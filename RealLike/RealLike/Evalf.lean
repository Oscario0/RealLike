import RealLike.Pipeline

open Lean Lean.Elab Lean.Elab.Command Lean.Elab.Term Lean.Meta

namespace RealLike

private def ensureRealLikeFunction (constName : Name) : TermElabM Unit := do
  let ci ← getConstInfo constName
  unless ci.type.containsConst (· == ``RealLike) do
    throwError
      m!"`#evalf` expects a `[RealLike α]`-polymorphic definition.\n" ++
      m!"Rewrite '{constName}' to take an implicit type and instance."

private def isRealLikeFunction (constName : Name) : TermElabM Bool := do
  let ci ← getConstInfo constName
  pure <| ci.type.containsConst (· == ``RealLike)

/--
`evalf% f arg₁ arg₂ …` evaluates a function numerically at `Float`.

If `f` is already polymorphic over `[RealLike α]`, it is instantiated directly.
If `f` is a concrete `ℝ`-valued definition, it is lowered to `RealLike` and then
specialized to `Float`.

```lean
def linear {α} [RealLike α] (x : α) : α := (x + 5) / 6
#eval (evalf% linear 3)
```
-/
elab "evalf%" fn:ident args:(ppSpace term:arg)* : term => do
  let constName ← resolveGlobalConstNoOverload fn
  let baseTerm : Term ←
    if (← isRealLikeFunction constName) then
      `($fn)
    else do
      let floatN ← getOrCreateFloat constName
      `($(mkIdent floatN))
  let mut appTerm : Term := baseTerm
  for arg in args do
    appTerm ← `($appTerm ($arg : Float))
  let finalTerm : Term ← `(($appTerm : Float))
  elabTerm finalTerm (some (mkConst ``Float))

end RealLike

open RealLike in
/--
`#evalf f arg₁ arg₂ …` evaluates a function numerically at `Float`.

If `f` is already polymorphic over `[RealLike α]`, it is instantiated directly.
If `f` is a concrete `ℝ`-valued definition, it is lowered to `RealLike` and then
specialized to `Float`.

```lean
def hypotenuse {α} [RealLike α] (a b : α) : α := RealLike.sqrt (a * a + b * b)
#evalf hypotenuse 3 4
```
-/
elab "#evalf" fn:ident args:(ppSpace term:arg)* : command => do
  let constName ← resolveGlobalConstNoOverload fn
  let baseTerm : Term ←
    if (← liftTermElabM <| isRealLikeFunction constName) then
      `($fn)
    else do
      let floatN ← liftTermElabM <| getOrCreateFloat constName
      `($(mkIdent floatN))
  let mut appTerm : Term := baseTerm
  for arg in args do
    appTerm ← `($appTerm ($arg : Float))
  let finalTerm : Term ← `(($appTerm : Float))
  elabEvalCore false fn finalTerm none
