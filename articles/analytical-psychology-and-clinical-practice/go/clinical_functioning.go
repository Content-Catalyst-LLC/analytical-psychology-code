package main

import "fmt"

func compensatoryPressure(consciousOnesidedness, complexActivation, traumaFragmentation, egoIntegration, shadowAwareness float64) float64 {
	return 0.62*consciousOnesidedness +
		0.58*complexActivation +
		0.34*traumaFragmentation -
		0.52*egoIntegration -
		0.26*shadowAwareness
}

func clinicalFunctioning(symptomBurden, egoIntegration, symbolicCapacity, relationalSafety, affectRegulation, compensatory, shadowAwareness float64) float64 {
	return -0.70*symptomBurden +
		0.60*egoIntegration +
		0.52*symbolicCapacity +
		0.64*relationalSafety -
		0.42*compensatory +
		0.28*affectRegulation +
		0.24*shadowAwareness
}

func main() {
	pressure := compensatoryPressure(0.36, 0.42, 0.24, 0.80, 0.80)
	score := clinicalFunctioning(0.38, 0.80, 0.76, 0.82, 0.78, pressure, 0.80)

	fmt.Printf("Synthetic compensatory pressure: %.3f\n", pressure)
	fmt.Printf("Synthetic clinical-functioning score: %.3f\n", score)
}
