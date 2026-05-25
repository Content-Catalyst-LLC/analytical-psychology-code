package main

import (
	"fmt"
	"math"
)

func totalityScore(
	egoCoherence,
	unconsciousActivation,
	symbolicCenterStrength,
	relationalCoordination,
	disjunction,
	inflationRisk float64,
) float64 {
	return 0.48*egoCoherence +
		0.36*unconsciousActivation +
		0.58*symbolicCenterStrength +
		0.54*relationalCoordination -
		0.46*disjunction -
		0.30*math.Max(inflationRisk, 0)
}

func selfRelationIndex(
	totality,
	differentiation,
	symbolicCenterStrength,
	inflationRisk float64,
) float64 {
	return 0.40*totality +
		0.34*differentiation +
		0.28*symbolicCenterStrength -
		0.30*math.Max(inflationRisk, 0)
}

func main() {
	totality := totalityScore(0.74, 0.66, 0.82, 0.76, 0.28, 0.18)
	selfRelation := selfRelationIndex(totality, 0.80, 0.82, 0.18)

	fmt.Printf("Synthetic totality score: %.3f\n", totality)
	fmt.Printf("Synthetic Self-relation index: %.3f\n", selfRelation)
}
