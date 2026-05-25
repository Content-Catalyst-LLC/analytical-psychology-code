package main

import (
	"fmt"
	"math"
)

func compensatorySignal(
	consciousOnesidedness,
	unconsciousPressure,
	affectiveIntensity,
	reflectiveCapacity float64,
) float64 {
	return 0.72*(unconsciousPressure-consciousOnesidedness) +
		0.42*affectiveIntensity -
		0.20*reflectiveCapacity
}

func symbolicRecurrence(
	previousDreamOutput,
	symbolicRepertoire,
	latentDevelopment float64,
) float64 {
	return 0.44*previousDreamOutput +
		0.36*symbolicRepertoire +
		0.24*latentDevelopment
}

func main() {
	comp := compensatorySignal(0.52, 0.66, 0.48, 0.60)
	recur := symbolicRecurrence(0.72, 0.56, 0.70)
	dreamOutput := 0.52*comp + 0.48*recur + 0.38*0.48 + 0.32*0.70
	integration := 0.42*0.60 + 0.38*0.70 + 0.30*0.56 - 0.24*math.Abs(comp)

	fmt.Printf("Synthetic compensatory signal: %.3f\n", comp)
	fmt.Printf("Synthetic symbolic recurrence: %.3f\n", recur)
	fmt.Printf("Synthetic dream output: %.3f\n", dreamOutput)
	fmt.Printf("Synthetic integration signal: %.3f\n", integration)
}
