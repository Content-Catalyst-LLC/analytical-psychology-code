package main

import "fmt"

func archetypalDepth(psychicPlurality, imaginalDensity, metaphoricalRichness, symptomImageIntensity, integrativePressure float64) float64 {
	return 0.65*psychicPlurality +
		0.70*imaginalDensity +
		0.58*metaphoricalRichness +
		0.46*symptomImageIntensity -
		0.55*integrativePressure
}

func main() {
	score := archetypalDepth(0.86, 0.91, 0.83, 0.64, 0.31)
	fmt.Printf("Synthetic archetypal-depth score: %.3f\n", score)
}
