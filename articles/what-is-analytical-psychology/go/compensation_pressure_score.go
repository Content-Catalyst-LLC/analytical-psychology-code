package main

import "fmt"

func compensationPressure(
	consciousOneSidedness,
	unconsciousActivation,
	symbolicIntensity,
	regulatoryCapacity float64,
) float64 {
	return consciousOneSidedness +
		unconsciousActivation +
		symbolicIntensity -
		regulatoryCapacity
}

func main() {
	score := compensationPressure(0.82, 0.74, 0.68, 0.36)
	fmt.Printf("Synthetic compensation pressure: %.3f\n", score)
}
