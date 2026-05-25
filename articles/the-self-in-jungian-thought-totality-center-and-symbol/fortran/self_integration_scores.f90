! The Self in Jungian Thought
! Fortran example: simple synthetic Self-integration score

program self_integration_scores_demo
  implicit none

  real :: totality
  real :: differentiation
  real :: symbolic_center
  real :: inflation_risk
  real :: self_relation

  symbolic_center = 0.82
  inflation_risk = 0.18
  differentiation = 0.80

  totality = 0.48 * 0.74 + 0.36 * 0.66 + 0.58 * symbolic_center + &
             0.54 * 0.76 - 0.46 * 0.28 - 0.30 * max(inflation_risk, 0.0)

  self_relation = 0.40 * totality + 0.34 * differentiation + &
                  0.28 * symbolic_center - 0.30 * max(inflation_risk, 0.0)

  print *, "Synthetic totality score:", totality
  print *, "Synthetic Self-relation index:", self_relation
end program self_integration_scores_demo
