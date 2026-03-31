import RealLike
import RealLike.Evalf
import PhysLean.StatisticalMechanics.BoltzmannConstant
import PhysLean.SpaceAndTime.Space.Basic
import PhysLean.SpaceAndTime.Time.Basic
import PhysLean.Thermodynamics.Temperature.Basic
import PhysLean.Units.WithDim.Basic

/-!
# Demo: `#evalf` on physlib wrappers

This file keeps physlib-facing regression examples separate from the core
`RealLike` demo. The goal is to exercise actual PhysLean wrapper types that
the `#evalf` bridge is expected to handle.
-/

open PhysLean
open Constants

noncomputable def spaceNormSq2 (x : Space 2) : ℝ :=
  x.val 0 * x.val 0 + x.val 1 * x.val 1

#evalf spaceNormSq2 (fun i : Fin 2 => if i = 0 then 3 else 4)

noncomputable def timeEnergy (t : Time) : ℝ :=
  Real.exp (-(t.val * t.val))

#evalf timeEnergy 2

noncomputable def timeShift (t : Time) : Time :=
  t + 1

#evalf timeShift 2

noncomputable def tempEnergy (T : Temperature) : ℝ :=
  Real.exp (-((T : ℝ) * (T : ℝ)))

#evalf tempEnergy 2

#evalf kB
#evalf Temperature.β 2
#evalf Temperature.ofβ 2

noncomputable def withDimNorm (x : WithDim 1 ℝ) : ℝ :=
  x.val * x.val

#evalf withDimNorm 3

noncomputable def withDimVectorNorm (x : WithDim 1 (Fin 2 → ℝ)) : ℝ :=
  x.val 0 * x.val 0 + x.val 1 * x.val 1

#evalf withDimVectorNorm (fun i : Fin 2 => if i = 0 then 3 else 4)

noncomputable def withDimNNHalf (x : WithDim 1 NNReal) : NNReal :=
  x.val / 2

#evalf withDimNNHalf 4
