package main

import "fmt"

func psychicIntegration(symbolicAccess, egoDifferentiation, containment, relationalDepth, transformation, culture, fragmentation float64) float64 {
	return 0.14*symbolicAccess + 0.14*egoDifferentiation + 0.13*containment + 0.13*relationalDepth + 0.14*transformation + 0.10*culture - 0.16*fragmentation
}

func main() {
	score := psychicIntegration(0.72, 0.66, 0.64, 0.70, 0.68, 0.55, 0.30)
	fmt.Printf("Psychic integration score: %.3f\n", score)
}
