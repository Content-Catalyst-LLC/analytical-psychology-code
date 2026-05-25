package main

import "fmt"

func egoCoherence(
	differentiation,
	unconsciousPressure,
	reflectiveFlexibility,
	oneSidedness float64,
) float64 {
	return 0.72*differentiation -
		0.48*unconsciousPressure +
		0.60*reflectiveFlexibility -
		0.22*oneSidedness
}

func psychicStrain(
	oneSidedness,
	unconsciousPressure,
	shadowActivation,
	egoRigidity,
	reflectiveFlexibility float64,
) float64 {
	return 0.40*oneSidedness +
		0.46*unconsciousPressure +
		0.42*shadowActivation +
		0.34*egoRigidity -
		0.44*reflectiveFlexibility
}

func main() {
	coherence := egoCoherence(0.80, 0.54, 0.72, 0.08)
	strain := psychicStrain(0.08, 0.54, 0.54, 0.20, 0.72)

	fmt.Printf("Synthetic ego coherence: %.3f\n", coherence)
	fmt.Printf("Synthetic psychic strain: %.3f\n", strain)
}
