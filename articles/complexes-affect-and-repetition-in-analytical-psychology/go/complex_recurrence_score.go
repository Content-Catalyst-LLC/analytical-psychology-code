package main

import "fmt"

func recurrencePressure(
	complexActivation,
	affectIntensity,
	projectionPressure,
	transferencePressure,
	regulationCapacity,
	relationalBuffer float64,
) float64 {
	return complexActivation +
		affectIntensity +
		projectionPressure +
		transferencePressure -
		regulationCapacity -
		relationalBuffer
}

func main() {
	score := recurrencePressure(0.86, 0.82, 0.44, 0.50, 0.36, 0.30)
	fmt.Printf("Synthetic recurrence pressure: %.3f\n", score)
}
