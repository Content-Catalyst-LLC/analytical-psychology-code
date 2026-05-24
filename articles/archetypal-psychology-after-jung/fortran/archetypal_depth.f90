! Archetypal Psychology After Jung
! Fortran example: simple synthetic archetypal-depth score

program archetypal_depth_demo
  implicit none

  real :: score

  score = 0.65 * 0.86 + 0.70 * 0.91 + 0.58 * 0.83 + &
          0.46 * 0.64 - 0.55 * 0.31

  print *, "Synthetic archetypal-depth score:", score
end program archetypal_depth_demo
