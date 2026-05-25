! Psychological Types: Introversion, Extraversion, and the Four Functions
! Fortran example: simple synthetic type-dynamics score

program type_dynamics_demo
  implicit none

  real :: strain
  real :: integration

  strain = 0.70 * (0.92 - 0.78) + 0.55 * 0.004 + &
           0.45 * 0.20 - 0.28 * 0.86

  integration = 0.42 * 0.78 + 0.38 * 0.84 + 0.36 * 0.86 - &
                0.32 * 0.004 - 0.26 * strain

  print *, "Synthetic compensation strain:", strain
  print *, "Synthetic developmental integration score:", integration
end program type_dynamics_demo
