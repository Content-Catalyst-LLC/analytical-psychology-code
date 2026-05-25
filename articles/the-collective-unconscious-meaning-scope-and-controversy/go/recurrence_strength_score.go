package main

import "fmt"

func recurrenceStrength(
	clusterStability,
	weightedCooccurrence,
	crossContextRecurrence,
	alternativeExplanationStrength float64,
) float64 {
	return 0.34*clusterStability +
		0.30*weightedCooccurrence +
		0.28*crossContextRecurrence -
		0.42*alternativeExplanationStrength
}

func main() {
	score := recurrenceStrength(0.72, 0.66, 0.58, 0.44)
	fmt.Printf("Synthetic recurrence strength after alternatives: %.3f\n", score)
}
