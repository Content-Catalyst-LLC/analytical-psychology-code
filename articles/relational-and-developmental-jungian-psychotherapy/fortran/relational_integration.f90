! Relational and Developmental Jungian Psychotherapy
! Fortran example: simple synthetic developmental integration score

program relational_integration_demo
  implicit none

  real :: score

  score = 0.62 * 0.82 + 0.42 * 0.74 + 0.55 * 0.74 + &
          0.46 * 0.78 + 0.36 * 0.74 + 0.58 * 0.76 + &
          0.44 * 0.78 - 0.58 * 0.32 - 0.38 * 0.42 - &
          0.28 * 0.26

  print *, "Synthetic developmental integration score:", score
end program relational_integration_demo
