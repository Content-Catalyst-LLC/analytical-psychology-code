package main

import "fmt"

func integrationPotential(
	egoIntegration,
	symbolicCapacity,
	relationalSafety,
	bodilyRegulation,
	memoryContinuity,
	symbolicRecovery,
	witnessingCapacity,
	dissociation,
	nightmareIntrusion float64,
) float64 {
	return 0.60*egoIntegration +
		0.55*symbolicCapacity +
		0.62*relationalSafety +
		0.48*bodilyRegulation +
		0.44*memoryContinuity +
		0.40*symbolicRecovery +
		0.32*witnessingCapacity -
		0.68*dissociation -
		0.34*nightmareIntrusion
}

func main() {
	score := integrationPotential(0.82, 0.80, 0.84, 0.80, 0.78, 0.76, 0.78, 0.24, 0.28)
	fmt.Printf("Synthetic trauma integration potential: %.3f\n", score)
}
