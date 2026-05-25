! Analytical Psychology and Personality Theory
! Fortran example: simple synthetic personality-state score

program personality_state_demo
  implicit none

  real :: onesidedness
  real :: score

  onesidedness = (0.88 - 0.86)**2 + (0.28 - 0.90)**2 + (0.18 - 0.96)**2

  score = 0.44 * 0.88 + 0.36 * 0.28 + 0.42 * 0.96 + &
          0.32 * 0.86 + 0.54 * 0.98 - 0.34 * abs(0.18) + &
          0.20 * 0.18

  print *, "Synthetic one-sidedness:", onesidedness
  print *, "Synthetic Jungian personality-state score:", score
end program personality_state_demo
