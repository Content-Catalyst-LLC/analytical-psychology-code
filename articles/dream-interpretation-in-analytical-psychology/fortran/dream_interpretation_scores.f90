! Dream Interpretation in Analytical Psychology
! Fortran example: simple synthetic dream-compensation score

program dream_interpretation_scores_demo
  implicit none

  real :: comp
  real :: recur
  real :: dream_output
  real :: integration

  comp = 0.72 * (0.66 - 0.52) + 0.42 * 0.48 - 0.20 * 0.60
  recur = 0.44 * 0.72 + 0.36 * 0.56 + 0.24 * 0.70

  dream_output = 0.52 * comp + 0.48 * recur + 0.38 * 0.48 + 0.32 * 0.70
  integration = 0.42 * 0.60 + 0.38 * 0.70 + 0.30 * 0.56 - 0.24 * abs(comp)

  print *, "Synthetic compensatory signal:", comp
  print *, "Synthetic symbolic recurrence:", recur
  print *, "Synthetic dream output:", dream_output
  print *, "Synthetic integration signal:", integration
end program dream_interpretation_scores_demo
