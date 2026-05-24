package main

import "fmt"

func comparativeQuality(recurrence, specificity, linguisticDepth, ritualContext, dialogicalAccountability, universalizingForce, abstractionPressure float64) float64 {
	return 0.52*recurrence +
		0.68*specificity +
		0.58*linguisticDepth +
		0.54*ritualContext +
		0.62*dialogicalAccountability -
		0.66*universalizingForce -
		0.42*abstractionPressure
}

func main() {
	score := comparativeQuality(0.76, 0.84, 0.79, 0.87, 0.77, 0.27, 0.30)
	fmt.Printf("Synthetic comparative-quality score: %.3f\n", score)
}
