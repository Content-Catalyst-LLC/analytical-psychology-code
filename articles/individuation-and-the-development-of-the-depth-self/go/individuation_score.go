package main

import (
	"fmt"
	"math"
)

func oneSidedness(
	egoCoherence,
	shadowAcknowledgment,
	symbolicRelation,
	complexActivation,
	personaIdentification,
	reflectiveCapacity float64,
) float64 {
	a := egoCoherence - shadowAcknowledgment
	b := symbolicRelation - complexActivation
	c := personaIdentification - reflectiveCapacity
	return a*a + b*b + c*c
}

func depthSelfIntegration(
	egoCoherence,
	shadowAcknowledgment,
	symbolicRelation,
	reflectiveCapacity,
	bodyAwareness,
	ethicalAccountability,
	relationalLife,
	complexActivation,
	oneSidednessValue float64,
) float64 {
	return 0.54*egoCoherence +
		0.62*shadowAcknowledgment +
		0.66*symbolicRelation +
		0.52*reflectiveCapacity +
		0.34*bodyAwareness +
		0.36*ethicalAccountability +
		0.30*relationalLife -
		0.42*math.Abs(complexActivation) -
		0.28*oneSidednessValue
}

func main() {
	w := oneSidedness(0.84, 0.86, 0.92, 0.28, 0.30, 0.90)
	score := depthSelfIntegration(0.84, 0.86, 0.92, 0.90, 0.76, 0.82, 0.82, 0.28, w)

	fmt.Printf("Synthetic one-sidedness: %.3f\n", w)
	fmt.Printf("Synthetic depth-self integration score: %.3f\n", score)
}
