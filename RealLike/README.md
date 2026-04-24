# RealLike

Real-valued functions are noncomputable and proving things float is really hard 
RealLike forms a bridge between Reals and Floats: you write ℝ formulas once, in Lean, and use the same definitions in two ways:

- for formal reasoning (`alpha = Real`, mathlib semantics)
- for executable numerical computation (`alpha = Float`, IEEE-754 semantics)

The scientific goal is not to pretend these semantics are identical. Instead,
the codebase makes their overlap explicit, exposes known mismatches, and
provides a path through Lean metaprogramming that turns real-valued functions into
numerically runnable kernels.

This is highlighted by two related ideas:

1. `RealLike`: one source function that supports proofs over `Real` and
   executable tests over `Float`.
2. `#evalf` and `evalf%`: tools designed using Lean metaprogramming that generate executable forms
   from real-valued function declarations.

## Background

### RealLike

This project started from a common practical pain point in Lean code: the
same quantities and/or models often had to be declared multiple times, once per
numeric type.

Typical workflow looked like this:

- declare a mathematically clean version over `Real` for theorems
- redeclare an executable version over `Float` for experiments
- keep both versions manually synchronized as the code grows

Now proofs and tests are no longer talking about the same model.

`RealLike` is the pattern used here to avoid that split:
That duplication is quite error-prone, especially for larger codebases
with many derived quantities and constrained wrapper types.

RealLike is motivated by making declarations uniform:

- define once against a shared interface (`[RealLike alpha]`)
- instantiate to `Real` for formal reasoning (`alpha = Real`)
- instantiate to `Float` for executable checks and unit tests (`alpha = Float`)

This unifies proof-facing and test-facing code paths around one declaration,
while still being explicit that `Real` and `Float` are not identical semantics.

### #evalf and #evalf%

After using the `RealLike` pattern, a second pain point remained: managing
three versions of the same thing (`Real`, `Float`, and polymorphic `alpha`) which was
still too much maintenance.

The goal became: keep the `Real` declaration and generate the rest implicitly.

- `#evalf` triggers the metaprogramming pipeline that lowers/specializes a
  real-valued function declaration into executable code.
- `evalf%` exposes the same machinery as an inline term form, so you can use it
  inside larger expressions (for example, after I/O operations).

Both these tools are meant to remove manual duplication and keep execution
close to the mathematically stated source.

## Scientific Motivation

For analysis and physics workflows, the goal is not to pretend `Real` and
`Float` are fully equivalent. The goal is to keep one equation-level model
coherent across proofs and execution.

This matters for three reasons:

- Avoid drift between theorem code and test code over time.
- Keep semantic differences explicit (domains, rounding behavior).
- Preserve a fast iteration loop by evaluating real-valued functions when
  needed.

In practice, this supports a workflow where you can prove against `Real`, run
checks against `Float`, and keep both tied to the same source-level function.

## Core Mathematical Interface

`RealLike alpha` provides:

- arithmetic and literals (`add`, `mul`, `div`, `neg`, `zero`, `one`, `ofNat`)
- order as boolean predicates (`le`, `lt`)
- nonlinear functions (`pow`, `sqrt`, `exp`, `log`, trig/hyperbolic families)
- rounding operators (`floor`, `ceil`, `round`)

It also installs Lean instances so ordinary notation works polymorphically:

- `Add`, `Mul`, `Div`, `Neg`, `Sub`, `OfNat`, `HPow`
- scientific literals through `OfScientific`

This means one expression can be interpreted in different ways numerically .

## Two Semantics, One Syntax

Instances are provided for:

- `Float`: executable IEEE-754 behavior
- `Real`: noncomputable mathlib behavior (`Real.rpow`, `Real.log`, etc.)

Important domain-sensitive differences are intentional and documented in
`RealLike/Class.lean`:

| Operation | Float behavior | Real behavior |
| --- | --- | --- |
| `sqrt x` for `x < 0` | `NaN` | `0` |
| `log x` for `x <= 0` | `NaN` or infinities | `0` at `x = 0`, `log |x|` for `x < 0` |
| `asin`, `acos` outside domain | `NaN` | clamped real definitions |
| `pow x y` with `x < 0`, noninteger `y` | `NaN` | `Real.rpow` semantics |
| `round` ties | away from zero | toward `+infinity` |
| `atan2 0 0` | IEEE branch behavior | branch via complex argument |

Hence, this library is a semantic bridge, not a proof that float
evaluation equals real evaluation.

## Lowering and Specialization Pipeline

For a concrete definition over `Real`, the pipeline is:

- `realToGeneric` in `RealLike/Lowering.lean`
- `specializeToFloat` in `RealLike/Specialize.lean`
- command/macro front-end in `RealLike/Evalf.lean`

Conceptually:

- Detect dependent real-valued definitions used in the target function.
- Rewrite their signatures and bodies from `Real` to `forall {alpha} [RealLike alpha], ...`.
- Rewrite operations (`Real.sin`, arithmetic overloads, coercions, wrappers) to `RealLike` operations.
- Emit hidden generated declarations:
   - `_evalf.<name>_generic`
   - `_evalf.<name>_float`
- Evaluate the float specialization through `#evalf` or `evalf%`.

## Data-Repr and Validation Layer

`RealLike/Repr.lean` introduces three complementary classes that matter for
scientific code carrying constraints.

- `EvalfBridge alpha`:
  reversible representation mapping (`toRepr` / `ofRepr`)
- `EvalfErase alpha`:
  one-way erasure for evaluation-only projection
- `EvalfValidate alpha`:
  checked conversion from raw values to constrained values

The validation API returns `Except String alpha`, allowing domain failures to be
reported explicitly (ex, nonnegativity constraints).

This supports safe raw numeric inputs for structured types while preserving
meaningful invariants.

## Physics-Oriented Wrappers

The lowering code contains dedicated handling for:

- `Subtype`-based scalar constraints
- `NNReal`
- single-field wrapper structures (including physlib-style wrappers)
- finite products and finite-indexed function spaces in representation classes

`Examples/PhysLeanDemo.lean` demonstrates this on physically typed quantities
(`Space`, `Time`, `Temperature`, dimensional wrappers), showing how real-valued
functions over wrapped types can still be evaluated numerically via `#evalf`.

## Usage

### 1. Install and build this repository

```bash
git clone https://github.com/Oscario0/RealLike.git
cd RealLike
lake update
lake build
```

The project is pinned to Lean `v4.28.0` via `lean-toolchain`.

### 2. Add RealLike as a dependency in another Lean project

Add this to your `lakefile.toml`:

```toml
[[require]]
name = "RealLike"
git = "https://github.com/Oscario0/RealLike"
rev = "main"
```

Then run:

```bash
lake update
lake build
```

### 3. Write one declaration and evaluate it

```lean
import RealLike
import RealLike.Evalf

def growth {alpha} [RealLike alpha] (r t : alpha) : alpha :=
	RealLike.exp (r * t)

#evalf growth 0.1 10

noncomputable def growthR (r t : Real) : Real :=
	Real.exp (r * t)

#evalf growthR 0.1 10
```

The first call instantiates a polymorphic declaration at `Float`. The second
call evaluates a declaration authored over `Real` through the lowering and
specialization pipeline.

### 4. Run included examples

```bash
lake env lean Examples/Demo.lean
lake env lean Examples/PhysLeanDemo.lean
lake env lean Examples/RaisingTests.lean
```

## Repository Map

- `RealLike.lean`: umbrella import for the core math layer
- `RealLike/Class.lean`: `RealLike` interface and semantic caveats
- `RealLike/Instances.lean`: `Float` and `Real` instances
- `RealLike/Derived.lean`: derived helpers (`exp2`, `log2`, `log10`, sign tests)
- `RealLike/Repr.lean`: bridge/erase/validate representation classes
- `RealLike/Lowering.lean`: Real-to-generic rewriting pass
- `RealLike/Specialize.lean`: generic-to-float specialization
- `RealLike/Raising.lean`: generic-to-real specialization helper
- `RealLike/Pipeline.lean`: one-step Real-to-Float pipeline entrypoint
- `RealLike/Evalf.lean`: `#evalf`, `evalf%`, and unsafe variants
- `Examples/Demo.lean`: core numerical examples
- `Examples/PhysLeanDemo.lean`: physically typed wrapper examples
- `Examples/RaisingTests.lean`: regression checks for generation idempotence
