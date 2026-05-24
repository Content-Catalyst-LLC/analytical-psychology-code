package main

import "fmt"

func relevanceScore(symbolicDepth, meaningCoherence, clinicalUtility, culturalInterpretivePower, revisionCapacity, doctrinalRigidity float64) float64 {
	return 0.62*symbolicDepth +
		0.58*meaningCoherence +
		0.54*clinicalUtility +
		0.48*culturalInterpretivePower +
		0.60*revisionCapacity -
		0.70*doctrinalRigidity
}

func main() {
	score := relevanceScore(0.82, 0.74, 0.58, 0.77, 0.69, 0.21)
	fmt.Printf("Synthetic relevance score: %.3f\n", score)
}
