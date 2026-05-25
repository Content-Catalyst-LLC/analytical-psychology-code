package main

import "fmt"

func personaStrength(
	roleDemand,
	audienceReward,
	institutionalReward,
	inwardComplexity,
	reflectiveFlexibility float64,
) float64 {
	return 0.64*roleDemand +
		0.48*audienceReward +
		0.36*institutionalReward -
		0.30*inwardComplexity +
		0.42*reflectiveFlexibility
}

func personaRigidity(
	personaStrengthValue,
	statusDependence,
	institutionalReward,
	reflectiveFlexibility float64,
) float64 {
	return 0.52*personaStrengthValue +
		0.42*statusDependence +
		0.34*institutionalReward -
		0.46*reflectiveFlexibility
}

func psychicStrain(
	personaStrengthValue,
	personaInwardGap,
	personaRigidityValue,
	shadowPressure,
	reflectiveFlexibility float64,
) float64 {
	return 0.50*personaStrengthValue +
		0.62*personaInwardGap*personaInwardGap +
		0.42*personaRigidityValue +
		0.36*shadowPressure -
		0.52*reflectiveFlexibility
}

func main() {
	strength := personaStrength(0.66, 0.50, 0.60, 0.70, 0.76)
	rigidity := personaRigidity(strength, 0.34, 0.60, 0.76)
	strain := psychicStrain(strength, 0.08, rigidity, 0.32, 0.76)

	fmt.Printf("Synthetic persona strength: %.3f\n", strength)
	fmt.Printf("Synthetic persona rigidity: %.3f\n", rigidity)
	fmt.Printf("Synthetic psychic strain: %.3f\n", strain)
}
