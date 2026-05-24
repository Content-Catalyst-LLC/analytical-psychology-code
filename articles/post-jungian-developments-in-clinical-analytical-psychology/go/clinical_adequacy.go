package main

import "fmt"

func clinicalAdequacy(symbolicDepth, relationalSophistication, developmentalPrecision, traumaSensitivity, embodiedRegulation, culturalResponsiveness, doctrinalRigidity float64) float64 {
	return 0.50*symbolicDepth +
		0.62*relationalSophistication +
		0.58*developmentalPrecision +
		0.66*traumaSensitivity +
		0.52*embodiedRegulation +
		0.46*culturalResponsiveness -
		0.60*doctrinalRigidity
}

func main() {
	score := clinicalAdequacy(0.84, 0.86, 0.82, 0.86, 0.82, 0.78, 0.24)
	fmt.Printf("Synthetic clinical-adequacy score: %.3f\n", score)
}
