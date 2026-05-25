package main

import (
	"fmt"
	"math"
)

func compensatoryIntensity(
	consciousOnesidedness,
	unconsciousPressure,
	affectiveIntensity,
	reflectiveCapacity float64,
) float64 {
	return 0.72*(unconsciousPressure-consciousOnesidedness) +
		0.36*affectiveIntensity -
		0.22*reflectiveCapacity
}

func prospectiveIntensity(
	latentGrowth,
	symbolicLiteracy,
	reflectiveCapacity,
	previousDreamOutput float64,
) float64 {
	return 0.64*latentGrowth +
		0.28*symbolicLiteracy +
		0.22*reflectiveCapacity +
		0.18*previousDreamOutput
}

func main() {
	comp := compensatoryIntensity(0.52, 0.66, 0.48, 0.60)
	prosp := prospectiveIntensity(0.72, 0.56, 0.60, 0.72)
	dreamOutput := 0.55*comp + 0.52*prosp + 0.40*0.48 + 0.32*0.72
	integration := 0.44*prosp + 0.36*0.60 + 0.30*0.56 - 0.24*math.Abs(comp)

	fmt.Printf("Synthetic compensatory intensity: %.3f\n", comp)
	fmt.Printf("Synthetic prospective intensity: %.3f\n", prosp)
	fmt.Printf("Synthetic dream output: %.3f\n", dreamOutput)
	fmt.Printf("Synthetic integration signal: %.3f\n", integration)
}
