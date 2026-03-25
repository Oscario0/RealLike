import RealLike.Raising

open Lean Elab Command

namespace RealLike

noncomputable def linearR_forRaise (x : ℝ) : ℝ := x + 3
noncomputable def cubicR_forRaise (x : ℝ) : ℝ := x * x * x - x - 1

/-- Case 1: generic form missing, so `getOrCreateReal` must create it, then specialize. -/
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

/-- Case 2: generic form already exists, so `getOrCreateReal` should reuse it. -/
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

/-- Case 3: idempotence: repeated calls should return the same generated real name. -/
run_cmd do
  let target := `linearR_forRaise
  let n1 ← liftTermElabM <| getOrCreateReal target
  let n2 ← liftTermElabM <| getOrCreateReal target
  unless n1 == n2 do
    throwError m!"Case 3 failed: expected stable name, got '{n1}' then '{n2}'"

/-- Case 4: direct specialization works once generic exists. -/
run_cmd do
  let target := `cubicR_forRaise
  let expectedReal := realName target

  let _ ← liftTermElabM <| realToGeneric target
  let produced ← liftTermElabM <| liftMetaM (specializeToReal target)
  unless produced == expectedReal do
    throwError m!"Case 4 failed: expected '{expectedReal}', got '{produced}'"

end RealLike
