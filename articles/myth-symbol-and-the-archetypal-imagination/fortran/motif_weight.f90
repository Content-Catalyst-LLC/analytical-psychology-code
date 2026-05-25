! Myth, Symbol, and the Archetypal Imagination
! Fortran example: simple motif co-occurrence weight

program motif_weight_demo
  implicit none

  integer :: weight
  real :: context_count
  real :: motif_total
  real :: share

  if (.true. .and. .true.) then
    weight = 1
  else
    weight = 0
  end if

  context_count = 4.0
  motif_total = 10.0

  if (motif_total > 0.0) then
    share = context_count / motif_total
  else
    share = 0.0
  end if

  print *, "Synthetic motif co-occurrence weight:", weight
  print *, "Synthetic context share:", share
end program motif_weight_demo
