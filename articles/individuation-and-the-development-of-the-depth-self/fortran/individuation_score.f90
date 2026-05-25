! Individuation and the Development of the Depth Self
! Fortran example: simple synthetic depth-self integration score

program individuation_score_demo
  implicit none

  real :: onesidedness
  real :: score

  onesidedness = (0.84 - 0.86)**2 + (0.92 - 0.28)**2 + (0.30 - 0.90)**2

  score = 0.54 * 0.84 + 0.62 * 0.86 + 0.66 * 0.92 + &
          0.52 * 0.90 + 0.34 * 0.76 + 0.36 * 0.82 + &
          0.30 * 0.82 - 0.42 * abs(0.28) - 0.28 * onesidedness

  print *, "Synthetic one-sidedness:", onesidedness
  print *, "Synthetic depth-self integration score:", score
end program individuation_score_demo
