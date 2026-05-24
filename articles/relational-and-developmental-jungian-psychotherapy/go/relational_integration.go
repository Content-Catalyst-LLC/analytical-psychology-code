package main

import "fmt"

func developmentalIntegration(
	relationalSafety,
	attachmentSecurity,
	affectRegulation,
	repairCapacity,
	embodiedSafety,
	symbolicCapacity,
	reflectiveSelf,
	fragmentation,
	shameLoad,
	ruptureIntensity float64,
) float64 {
	return 0.62*relationalSafety +
		0.42*attachmentSecurity +
		0.55*affectRegulation +
		0.46*repairCapacity +
		0.36*embodiedSafety +
		0.58*symbolicCapacity +
		0.44*reflectiveSelf -
		0.58*fragmentation -
		0.38*shameLoad -
		0.28*ruptureIntensity
}

func main() {
	score := developmentalIntegration(
		0.82, 0.74, 0.74, 0.78, 0.74, 0.76, 0.78, 0.32, 0.42, 0.26,
	)
	fmt.Printf("Synthetic developmental integration score: %.3f\n", score)
}
