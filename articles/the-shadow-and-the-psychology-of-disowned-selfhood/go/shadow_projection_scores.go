package main

import (
	"fmt"
	"math"
)

func shadowActivation(
	latentDisowned,
	cueIntensity,
	shadowDiscrepancy,
	affectiveCharge,
	reflectiveCapacity float64,
) float64 {
	return 0.72*latentDisowned*cueIntensity +
		0.56*shadowDiscrepancy +
		0.42*affectiveCharge -
		0.48*reflectiveCapacity
}

func projectionIntensity(
	shadowActivationValue,
	affectiveCharge,
	personaRigidity,
	reflectiveCapacity float64,
) float64 {
	return 0.76*shadowActivationValue +
		0.44*affectiveCharge +
		0.32*personaRigidity -
		0.56*reflectiveCapacity
}

func integrationCapacity(
	reflectiveCapacity,
	projectionIntensityValue,
	shameResponse,
	developmentalTime float64,
) float64 {
	return 0.50*reflectiveCapacity -
		0.34*math.Abs(projectionIntensityValue) -
		0.26*shameResponse +
		0.28*developmentalTime
}

func main() {
	shadow := shadowActivation(0.58, 0.46, 0.02, 0.48, 0.74)
	projection := projectionIntensity(shadow, 0.48, 0.52, 0.74)
	integration := integrationCapacity(0.74, projection, 0.24, 1.0)

	fmt.Printf("Synthetic shadow activation: %.3f\n", shadow)
	fmt.Printf("Synthetic projection intensity: %.3f\n", projection)
	fmt.Printf("Synthetic integration capacity: %.3f\n", integration)
}
