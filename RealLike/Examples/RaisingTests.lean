import RealLike.Raising

open Lean Elab Command

namespace RealLike

noncomputable def linearR_forRaise (x : ℝ) : ℝ := x + 3
noncomputable def cubicR_forRaise (x : ℝ) : ℝ := x * x * x - x - 1
run_cmd do
  let target := `linearR_forRaise
  let expectedGen := genericName target
  let expectedReal := realName target

  let produced ← liftTermElabM <| getOrCreateReal target
  unless produced == expectedReal do
    throwError m!"Case 1 failed: expected '{expectedReal}', got '{produced}'"

  let env ← getEnv
  unless (env.find? expectedGen).isSome do
    throwError m!"Case 1 failed: missing generated generic '{expectedGen}'"
  unless (env.find? expectedReal).isSome do
    throwError m!"Case 1 failed: missing generated real specialization '{expectedReal}'"
run_cmd do
  let target := `cubicR_forRaise
  let expectedGen := genericName target
  let expectedReal := realName target

  let _ ← liftTermElabM <| realToGeneric target
  let produced ← liftTermElabM <| getOrCreateReal target
  unless produced == expectedReal do
    throwError m!"Case 2 failed: expected '{expectedReal}', got '{produced}'"

  let env ← getEnv
  unless (env.find? expectedGen).isSome do
    throwError m!"Case 2 failed: missing generic '{expectedGen}'"
  unless (env.find? expectedReal).isSome do
    throwError m!"Case 2 failed: missing real specialization '{expectedReal}'"
run_cmd do
  let target := `linearR_forRaise
  let n1 ← liftTermElabM <| getOrCreateReal target
  let n2 ← liftTermElabM <| getOrCreateReal target
  unless n1 == n2 do
    throwError m!"Case 3 failed: expected stable name, got '{n1}' then '{n2}'"
run_cmd do
  let target := `cubicR_forRaise
  let expectedReal := realName target

  let _ ← liftTermElabM <| realToGeneric target
  let produced ← liftTermElabM <| liftMetaM (specializeToReal target)
  unless produced == expectedReal do
    throwError m!"Case 4 failed: expected '{expectedReal}', got '{produced}'"

end RealLike
