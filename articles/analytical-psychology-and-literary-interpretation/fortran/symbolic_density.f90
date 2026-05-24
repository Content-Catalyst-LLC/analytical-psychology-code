! Analytical Psychology and Literary Interpretation
! Fortran example: simple symbolic-density score

program symbolic_density_demo
  implicit none

  integer :: motif_count, total_tokens
  real :: density

  motif_count = 8
  total_tokens = 120

  if (total_tokens > 0) then
     density = real(motif_count) / real(total_tokens)
  else
     density = 0.0
  end if

  print *, "Synthetic symbolic-density score:", density
end program symbolic_density_demo
