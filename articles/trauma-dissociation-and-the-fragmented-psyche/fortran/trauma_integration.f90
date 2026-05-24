! Trauma, Dissociation, and the Fragmented Psyche
! Fortran example: simple synthetic integration potential score

program trauma_integration_demo
  implicit none

  real :: score

  score = 0.60 * 0.82 + 0.55 * 0.80 + 0.62 * 0.84 + &
          0.48 * 0.80 + 0.44 * 0.78 + 0.40 * 0.76 + &
          0.32 * 0.78 - 0.68 * 0.24 - 0.34 * 0.28

  print *, "Synthetic trauma integration potential:", score
end program trauma_integration_demo
