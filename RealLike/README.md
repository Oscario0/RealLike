# RealLike

`RealLike` is a Lean typeclass for writing real-valued computations once and
running them both:

- abstractly over `ℝ`, for proofs
- concretely over `Float`, for evaluation

The package also provides lightweight `#evalf` and `evalf%` commands for
evaluating `RealLike`-polymorphic definitions at `Float`.

## Imports

For the math layer:

```lean
import RealLike
```

For the optional evaluation commands as well:

```lean
import RealLike
import RealLike.Evalf
```

## Basic idea

Write definitions polymorphically over `[RealLike α]`:

```lean
import RealLike
import RealLike.Evalf

def linear {α} [RealLike α] (x : α) : α := (x + 5) / 6

#eval linear (3.0 : Float)
#evalf linear 3
```

This same definition can be used at `Float` for computation and at `ℝ` for
reasoning.

## Module layout

- `RealLike.lean`: public math umbrella
- `RealLike/Class.lean`: the `RealLike` typeclass and bridge instances
- `RealLike/Instances.lean`: `Float` and `ℝ` instances
- `RealLike/Derived.lean`: derived helpers like `exp2`, `log2`, `log10`
- `RealLike/Evalf.lean`: `#evalf` and `evalf%`
- `Examples/Demo.lean`: example usage

## Semantic notes

`RealLike` intentionally exposes operations whose `Float` and `ℝ` behavior do
not perfectly agree. The most important caveats are documented in
[`RealLike/Class.lean`](/Users/tylerjosephson/Dropbox/Lean/evalf/RealLike/RealLike/Class.lean).

In particular, pay attention to:

- `sqrt` on negative inputs
- `log` on nonpositive inputs
- `asin` and `acos` outside their usual domains
- `pow` on negative bases
- `round` at half-integers
- `atan2`, especially at `(0, 0)`

## Example

See [`Examples/Demo.lean`](/Users/tylerjosephson/Dropbox/Lean/evalf/RealLike/Examples/Demo.lean)
for a small collection of `RealLike`-polymorphic definitions evaluated with
`#evalf`.
