! Active Imagination and the Practice of Symbolic Dialogue
! Fortran example: simple synthetic symbolic-integration score

program dialogue_integration_demo
  implicit none

  real :: risk
  real :: score
  real :: imbalance
  real :: positive_risk

  risk = 0.54 * 0.56 - 0.38 * 0.88 - 0.34 * 0.88
  imbalance = 0.88 - 0.56
  positive_risk = max(risk, 0.0)

  score = 0.56 * 0.88 + 0.52 * 0.56 + 0.48 * 0.88 + &
          0.44 * 0.90 + 0.34 * 0.86 - 0.70 * imbalance * imbalance - &
          0.28 * positive_risk

  print *, "Synthetic destabilization risk:", risk
  print *, "Synthetic symbolic integration score:", score
end program dialogue_integration_demo
