package main

import "fmt"

func freudianScore(repression, sexualityConflict, infantileHistory, defenseIntensity, transferencePressure, mythicAmplification float64) float64 {
	return 0.66*repression +
		0.70*sexualityConflict +
		0.62*infantileHistory +
		0.58*defenseIntensity +
		0.50*transferencePressure -
		0.30*mythicAmplification
}

func jungianScore(compensation, archetypalDensity, prospectiveDevelopment, mythicAmplification, symbolicCoherence, individuationPressure, repression float64) float64 {
	return 0.58*compensation +
		0.70*archetypalDensity +
		0.62*prospectiveDevelopment +
		0.64*mythicAmplification +
		0.60*symbolicCoherence +
		0.56*individuationPressure -
		0.24*repression
}

func main() {
	f := freudianScore(0.84, 0.78, 0.82, 0.76, 0.69, 0.28)
	j := jungianScore(0.36, 0.30, 0.34, 0.28, 0.38, 0.32, 0.84)

	fmt.Printf("Synthetic Freudian score: %.3f\n", f)
	fmt.Printf("Synthetic Jungian score: %.3f\n", j)
}
