package main

import (
	"fmt"
	"math"
)

func oneSidedness(
	consciousOrientation,
	shadowAcknowledgment,
	personaIdentification,
	typologicalFlexibility,
	complexActivation,
	symbolicRelation float64,
) float64 {
	a := consciousOrientation - shadowAcknowledgment
	b := personaIdentification - typologicalFlexibility
	c := complexActivation - symbolicRelation
	return a*a + b*b + c*c
}

func personalityState(
	consciousOrientation,
	personaIdentification,
	symbolicRelation,
	shadowAcknowledgment,
	developmentalIntegration,
	complexActivation,
	unconsciousCompensation float64,
) float64 {
	return 0.44*consciousOrientation +
		0.36*personaIdentification +
		0.42*symbolicRelation +
		0.32*shadowAcknowledgment +
		0.54*developmentalIntegration -
		0.34*math.Abs(complexActivation) +
		0.20*unconsciousCompensation
}

func main() {
	w := oneSidedness(0.88, 0.86, 0.28, 0.90, 0.18, 0.96)
	score := personalityState(0.88, 0.28, 0.96, 0.86, 0.98, 0.18, 0.18)

	fmt.Printf("Synthetic one-sidedness: %.3f\n", w)
	fmt.Printf("Synthetic Jungian personality-state score: %.3f\n", score)
}
