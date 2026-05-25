package main

import "fmt"

func complexPressure(
	complexActivation,
	affectIntensity,
	unresolvedAffect,
	projectionPressure,
	transferencePressure,
	regulationCapacity,
	contextualSupport float64,
) float64 {
	return complexActivation +
		affectIntensity +
		unresolvedAffect +
		projectionPressure +
		transferencePressure -
		regulationCapacity -
		contextualSupport
}

func main() {
	score := complexPressure(0.86, 0.82, 0.72, 0.44, 0.50, 0.36, 0.30)
	fmt.Printf("Synthetic complex pressure: %.3f\n", score)
}
