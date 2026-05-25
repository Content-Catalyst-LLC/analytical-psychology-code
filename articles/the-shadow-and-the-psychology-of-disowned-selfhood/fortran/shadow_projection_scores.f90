! The Shadow and the Psychology of Disowned Selfhood
! Fortran example: simple synthetic shadow-projection score

program shadow_projection_scores_demo
  implicit none

  real :: shadow
  real :: projection
  real :: integration

  shadow = 0.72 * 0.58 * 0.46 + 0.56 * 0.02 + 0.42 * 0.48 - 0.48 * 0.74
  projection = 0.76 * shadow + 0.44 * 0.48 + 0.32 * 0.52 - 0.56 * 0.74
  integration = 0.50 * 0.74 - 0.34 * abs(projection) - 0.26 * 0.24 + 0.28 * 1.0

  print *, "Synthetic shadow activation:", shadow
  print *, "Synthetic projection intensity:", projection
  print *, "Synthetic integration capacity:", integration
end program shadow_projection_scores_demo
