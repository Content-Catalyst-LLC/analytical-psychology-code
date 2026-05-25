package main

import "fmt"

func compensationStrain(
	dominantStrength,
	inferiorStrength,
	functionVariance,
	unconsciousPressure,
	reflectiveCapacity float64,
) float64 {
	gap := dominantStrength - inferiorStrength
	return 0.70*gap +
		0.55*functionVariance +
		0.45*unconsciousPressure -
		0.28*reflectiveCapacity
}

func developmentalIntegration(
	inferiorStrength,
	symbolicRelation,
	reflectiveCapacity,
	functionVariance,
	strain float64,
) float64 {
	return 0.42*inferiorStrength +
		0.38*symbolicRelation +
		0.36*reflectiveCapacity -
		0.32*functionVariance -
		0.26*strain
}

func main() {
	strain := compensationStrain(0.92, 0.78, 0.004, 0.20, 0.86)
	integration := developmentalIntegration(0.78, 0.84, 0.86, 0.004, strain)

	fmt.Printf("Synthetic compensation strain: %.3f\n", strain)
	fmt.Printf("Synthetic developmental integration score: %.3f\n", integration)
}
