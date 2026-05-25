! Dreams, Compensation, and the Prospective Function
! Fortran example: simple synthetic dream-dynamics score

program dream_dynamics_demo
  implicit none

  real :: comp
  real :: prosp
  real :: dream_output
  real :: integration

  comp = 0.72 * (0.66 - 0.52) + 0.36 * 0.48 - 0.22 * 0.60
  prosp = 0.64 * 0.72 + 0.28 * 0.56 + 0.22 * 0.60 + 0.18 * 0.72

  dream_output = 0.55 * comp + 0.52 * prosp + 0.40 * 0.48 + 0.32 * 0.72
  integration = 0.44 * prosp + 0.36 * 0.60 + 0.30 * 0.56 - 0.24 * abs(comp)

  print *, "Synthetic compensatory intensity:", comp
  print *, "Synthetic prospective intensity:", prosp
  print *, "Synthetic dream output:", dream_output
  print *, "Synthetic integration signal:", integration
end program dream_dynamics_demo
