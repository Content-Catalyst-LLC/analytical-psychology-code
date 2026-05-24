package main

import "fmt"

func developmentalStrain(egoDifferentiation, relationalSecurity, symbolicCapacity, complexActivation float64) float64 {
	eR := egoDifferentiation - relationalSecurity
	sR := symbolicCapacity - relationalSecurity
	return eR*eR + sR*sR + complexActivation*complexActivation
}

func developmentalCoherence(
	egoDifferentiation,
	relationalSecurity,
	symbolicCapacity,
	affectRegulation,
	symbolicPlay,
	complexActivation,
	strain float64,
) float64 {
	return 0.55*egoDifferentiation +
		0.70*relationalSecurity +
		0.60*symbolicCapacity +
		0.48*affectRegulation +
		0.34*symbolicPlay -
		0.50*complexActivation -
		0.24*strain
}

func main() {
	strain := developmentalStrain(0.82, 0.90, 0.90, 0.18)
	score := developmentalCoherence(0.82, 0.90, 0.90, 0.82, 0.90, 0.18, strain)

	fmt.Printf("Synthetic developmental strain: %.3f\n", strain)
	fmt.Printf("Synthetic developmental coherence score: %.3f\n", score)
}
