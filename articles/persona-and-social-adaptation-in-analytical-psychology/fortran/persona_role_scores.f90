! Persona and Social Adaptation in Analytical Psychology
! Fortran example: simple synthetic persona-role score

program persona_role_scores_demo
  implicit none

  real :: strength
  real :: rigidity
  real :: strain

  strength = 0.64 * 0.66 + 0.48 * 0.50 + 0.36 * 0.60 - 0.30 * 0.70 + 0.42 * 0.76
  rigidity = 0.52 * strength + 0.42 * 0.34 + 0.34 * 0.60 - 0.46 * 0.76
  strain = 0.50 * strength + 0.62 * 0.08 * 0.08 + 0.42 * rigidity + 0.36 * 0.32 - 0.52 * 0.76

  print *, "Synthetic persona strength:", strength
  print *, "Synthetic persona rigidity:", rigidity
  print *, "Synthetic psychic strain:", strain
end program persona_role_scores_demo
