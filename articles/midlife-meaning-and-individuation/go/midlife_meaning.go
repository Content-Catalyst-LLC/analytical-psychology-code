package main

import "fmt"

func meaningCoherence(
	adaptationStrength,
	symbolicActivation,
	individuationPressure,
	shadowIntegration,
	reflectiveCapacity,
	outwardInwardDiscrepancy float64,
) float64 {
	return 0.40*adaptationStrength +
		0.58*symbolicActivation +
		0.62*individuationPressure +
		0.42*shadowIntegration +
		0.36*reflectiveCapacity -
		0.72*outwardInwardDiscrepancy
}

func main() {
	score := meaningCoherence(0.54, 0.90, 0.88, 0.86, 0.86, 0.28)
	fmt.Printf("Synthetic midlife meaning coherence score: %.3f\n", score)
}
