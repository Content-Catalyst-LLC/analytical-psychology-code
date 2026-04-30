program symbolic_integration
  implicit none

  integer :: t
  real :: integration
  real, parameter :: symbolic_access = 0.70
  real, parameter :: ego_differentiation = 0.62
  real, parameter :: relational_depth = 0.66
  real, parameter :: fragmentation = 0.30
  real, parameter :: rate = 0.07

  integration = 0.40

  print *, "Time", "Integration"

  do t = 1, 20
     integration = integration + rate * (symbolic_access + ego_differentiation + relational_depth - fragmentation)
     if (integration > 1.0) integration = 1.0
     if (integration < 0.0) integration = 0.0
     print *, t, integration
  end do

end program symbolic_integration
