package main

import (
	"fmt"
	"math"
)

func transformationScore(nigredoPressure, albedoClarity, rubedoVitality, vesselStrength, onesidedness, mercurialVolatility float64) float64 {
	return 0.42*nigredoPressure +
		0.55*albedoClarity +
		0.66*rubedoVitality +
		0.58*vesselStrength -
		0.60*onesidedness -
		0.30*math.Abs(mercurialVolatility)
}

func main() {
	score := transformationScore(0.70, 0.52, 0.44, 0.58, 0.62, 0.84)
	fmt.Printf("Synthetic alchemical transformation score: %.3f\n", score)
}
