package main

import "fmt"

func conceptTransitionScore(
	earlyWeight,
	middleWeight,
	lateWeight,
	postJungianRevisionWeight float64,
) float64 {
	return -0.20*earlyWeight +
		0.35*middleWeight +
		0.40*lateWeight +
		0.45*postJungianRevisionWeight
}

func main() {
	score := conceptTransitionScore(0.30, 0.88, 0.80, 0.74)
	fmt.Printf("Synthetic concept-transition score: %.3f\n", score)
}
