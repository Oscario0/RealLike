import bisection

open Bisection

namespace CompressibilityFactor

/-- Van der Waals cubic in the compressibility factor `Z`. -/
def vanDerWaalsEquation (A B : Float) (Z : Float) : Float :=
  Z * Z * Z - (1.0 + B) * Z * Z + A * Z - A * B

def nitrogenExample : BisectionResult Float :=
  let A := 0.42
  let B := 0.08
  Bisection.bisectionCore (vanDerWaalsEquation A B) 0.1 2.0
    { tolerance := 0.0001, maxIterations := 100 }

def idealGasExample : BisectionResult Float :=
  let equation (Z : Float) := Z - 1.0
  Bisection.bisectionCore equation 0.5 1.5
    { tolerance := 0.0001, maxIterations := 100 }

def highPressureExample : BisectionResult Float :=
  let A := 0.2
  let B := 0.15
  Bisection.bisectionCore (vanDerWaalsEquation A B) 1.0 2.0
    { tolerance := 0.0001, maxIterations := 100 }

def lowTempExample : BisectionResult Float :=
  let A := 1.5
  let B := 0.05
  Bisection.bisectionCore (vanDerWaalsEquation A B) 0.1 1.0
    { tolerance := 0.0001, maxIterations := 100 }

/-- Redlich-Kwong cubic in the compressibility factor `Z`. -/
def redlichKwongEquation (A B : Float) (Z : Float) : Float :=
  Z * Z * Z - Z * Z + (A - B - B * B) * Z - A * B

def redlichKwongExample : BisectionResult Float :=
  let A := 0.5
  let B := 0.08
  Bisection.bisectionCore (redlichKwongEquation A B) 0.1 2.0
    { tolerance := 0.0001, maxIterations := 100 }

#eval nitrogenExample
#eval idealGasExample
#eval highPressureExample
#eval lowTempExample
#eval redlichKwongExample

end CompressibilityFactor
