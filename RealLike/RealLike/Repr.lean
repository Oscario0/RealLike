import Mathlib.Data.Fintype.Basic
import Mathlib.Data.NNReal.Basic
import RealLike.Instances

open scoped RealLike

namespace RealLike

universe u v w

abbrev Validation (α : Type u) := Except String α

abbrev Nonnegative (α : Type) [RealLike α] : Type :=
  { x : α // RealLike.le (0 : α) x = true }

def require (cond : Bool) (message : String) : Validation PUnit :=
  if cond then
    .ok ⟨⟩
  else
    .error message

class EvalfBridge (α : Type u) where
  Repr : Type v
  toRepr : α → Repr
  ofRepr : Repr → α

abbrev EvalfRepr (α : Type u) [EvalfBridge α] : Type _ :=
  EvalfBridge.Repr α

export EvalfBridge (toRepr ofRepr)

instance : EvalfBridge Float where
  Repr := Float
  toRepr := id
  ofRepr := id

noncomputable instance : EvalfBridge ℝ where
  Repr := ℝ
  toRepr := id
  ofRepr := id

instance [EvalfBridge α] [EvalfBridge β] : EvalfBridge (α × β) where
  Repr := EvalfRepr α × EvalfRepr β
  toRepr x := (toRepr x.1, toRepr x.2)
  ofRepr x := (ofRepr x.1, ofRepr x.2)

instance {ι : Type u} [Fintype ι] [EvalfBridge α] : EvalfBridge (ι → α) where
  Repr := ι → EvalfRepr α
  toRepr f := fun i => toRepr (f i)
  ofRepr f := fun i => ofRepr (f i)

def bridgeField (mk : β → α) (get : α → β) [EvalfBridge β] : EvalfBridge α where
  Repr := EvalfRepr β
  toRepr x := toRepr (get x)
  ofRepr x := mk (ofRepr x)

class EvalfErase (α : Type u) where
  Repr : Type v
  erase : α → Repr

abbrev EvalfErased (α : Type u) [EvalfErase α] : Type _ :=
  EvalfErase.Repr α

export EvalfErase (erase)

def eraseField (get : α → β) [EvalfErase β] : EvalfErase α where
  Repr := EvalfErased β
  erase x := erase (get x)

instance [EvalfBridge α] : EvalfErase α where
  Repr := EvalfRepr α
  erase := toRepr

instance [EvalfErase α] [EvalfErase β] : EvalfErase (α × β) where
  Repr := EvalfErased α × EvalfErased β
  erase x := (erase x.1, erase x.2)

instance {ι : Type u} [Fintype ι] [EvalfErase α] : EvalfErase (ι → α) where
  Repr := ι → EvalfErased α
  erase f := fun i => erase (f i)

instance {α : Type u} {p : α → Prop} [EvalfErase α] : EvalfErase (Subtype p) where
  Repr := EvalfErased α
  erase x := erase x.1

noncomputable instance : EvalfErase NNReal where
  Repr := EvalfErased ℝ
  erase x := erase (x : ℝ)

class EvalfValidate (α : Type u) where
  Raw : Type u
  fromRaw? : Raw → Validation α
  toRaw : α → Raw

abbrev EvalfRaw (α : Type u) [EvalfValidate α] : Type _ :=
  EvalfValidate.Raw α

export EvalfValidate (fromRaw? toRaw)

instance : EvalfValidate Float where
  Raw := Float
  fromRaw? := .ok
  toRaw := id

noncomputable instance : EvalfValidate ℝ where
  Raw := ℝ
  fromRaw? := .ok
  toRaw := id

noncomputable instance : EvalfValidate NNReal where
  Raw := ℝ
  fromRaw? x :=
    if x < 0 then
      .error "expected a nonnegative input"
    else
      .ok <| Real.toNNReal x
  toRaw x := x

instance : EvalfValidate (Nonnegative Float) where
  Raw := Float
  fromRaw? x :=
    if h : RealLike.le (0 : Float) x = true then
      .ok ⟨x, h⟩
    else
      .error "expected a nonnegative input"
  toRaw x := x.1

noncomputable instance : EvalfValidate (Nonnegative ℝ) where
  Raw := ℝ
  fromRaw? x :=
    if h : RealLike.le (0 : ℝ) x = true then
      .ok ⟨x, h⟩
    else
      .error "expected a nonnegative input"
  toRaw x := x.1

instance {α : Type u} {p : α → Prop} [EvalfValidate α] [DecidablePred p] :
    EvalfValidate (Subtype p) where
  Raw := EvalfRaw α
  fromRaw? x := do
    let y ← fromRaw? x
    if h : p y then
      return ⟨y, h⟩
    else
      .error "subtype predicate failed"
  toRaw x := toRaw x.1

def unsafeFromRaw [EvalfValidate α] [Inhabited α] (x : EvalfRaw α) : α :=
  match fromRaw? x with
  | .ok y => y
  | .error message => panic! message

unsafe def unsafeUncheckedFromRaw [EvalfValidate α] (x : EvalfRaw α) : α :=
  unsafeCast x

set_option linter.style.nativeDecide false in
instance : Inhabited (Nonnegative Float) where
  default := by
    refine ⟨0, ?_⟩
    native_decide

noncomputable instance : Inhabited (Nonnegative ℝ) where
  default := ⟨0, by simp [RealLike.le]⟩

end RealLike
