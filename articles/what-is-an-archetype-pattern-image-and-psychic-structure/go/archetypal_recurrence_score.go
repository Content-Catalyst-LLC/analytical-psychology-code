package main

import "fmt"

func recurrenceStrength(clusterStability, weightedCooccurrence, crossContextRecurrence, culturalFlatteningRisk float64) float64 {
	return 0.34*clusterStability + 0.30*weightedCooccurrence + 0.28*crossContextRecurrence - 0.42*culturalFlatteningRisk
}

func main() {
	fmt.Printf("Synthetic recurrence strength: %.3f\n", recurrenceStrength(0.72, 0.66, 0.58, 0.30))
}
