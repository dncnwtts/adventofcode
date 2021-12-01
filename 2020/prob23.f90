program prob23
  implicit none
  integer(kind=16), dimension(9) :: cups, cups_buff
  integer(kind=16), dimension(3) :: move
  integer(kind=16) :: i, j, current, current_ind, destination, destination_ind, moves
  integer(kind=16) :: cup1, cup2, cup3, nxt, a, c

  integer(kind=16), dimension(1000000) :: cups2, links


  ! Test configuration
  cups = (/ 3, 8, 9, 1, 2, 5, 4, 6, 7 /)
  current = 3

  ! My input
  cups = (/ 1, 8, 6, 5, 2, 4, 9, 7, 3 /)
  current = 1


  current_ind = 1
  cups_buff = 0
  moves = 100

  do i = 1, moves
    ! write(*,'(A,I3,A)') '-- move', i, ' --'
    ! At every step, rearrange so that the current cup lies at index 1.

    ! write(*, '(A,I2)') 'current:', current

    ! write(*,'(A,10I2)') 'cups:', cups


    move = cups(2:4)
    ! write(*,'(A,10I2)') 'pick up:', move
    cups_buff = 0
    cups_buff(1) = cups(1)
    cups_buff(2:6) = cups(5:9)

    destination = mod(current - 1_16 + 9_16 - 1_16, 9_16) + 1_16
    ! if destination is in the moved cups, subtract until it isn't
    do
      destination_ind = 0_16
      do j = 1_16, 3_16
        if (move(j) == destination) then
          destination_ind = j
        end if
      end do
      if (destination_ind .ne. 0_16) then
        destination = mod(destination - 1_16 + 9_16 - 1_16, 9_16) + 1_16
      else
        exit
      end if
    end do
    ! write(*,'(A,I2)') 'destination:', destination

    ! Move the cups you picked up to the cups to the right of the destination
    do j = 1, 6
      if (cups_buff(j) == destination) then
        cups(:j) = cups_buff(:j)
        cups(j+1:j+3) = move
        destination_ind = j
      end if
    end do
    cups(destination_ind+4:) = cups_buff(destination_ind+1:6)


    cups_buff = cups
    cups_buff(1:8) = cups(2:9)
    cups_buff(9) = cups(1)
    cups = cups_buff
    current = cups(1)

    ! write(*,*)

  end do

  ! write(*,'(A,10I2)') 'cups:', cups
  ! rearrange input so that 1 is the last index
  do i = 1, 9
    if (cups(i) == 1) then
      j = i
    end if
  end do
  cups_buff = cups
  do i = 1_16, 9_16
    cups(i) = cups_buff(mod(j+i-1_16, 9_16)+1_16)
  end do
  write(*,'(8I1)') cups(1:8)


  ! Implemented solution as written up 
  ! here:
  ! https://www.reddit.com/r/adventofcode/comments/kimluc/2020_day_23_solutions/gh7o5ak?utm_source = share&utm_medium = web2x&context = 3

  ! Test configuration
  cups = (/ 3, 8, 9, 1, 2, 5, 4, 6, 7 /)
  current = 3

  ! My input
  cups = (/ 1, 8, 6, 5, 2, 4, 9, 7, 3 /)
  current = 1

  cups2(1:9) = cups
  do i = 10, 1000000
    cups2(i) = i
  end do

  links = 0
  do i = 1, 1000000
    links(cups2(i)) = cups2(mod(i+1_16-1_16, 1000000_16) + 1_16)
  end do


  moves = 10000000

  do i = 1, moves
    cup1 = links(current)
    cup2 = links(cup1)
    cup3 = links(cup2)
    nxt  = links(cup3)

    destination = mod(current - 1_16 + 1000000_16 - 1_16, 1000000_16) + 1_16

    do
      if (cup1 .ne. destination .and. cup2 .ne. destination .and. cup3 .ne. destination &
        .and. destination > 0) then
        exit
      else
        destination = destination - 1
        if (destination < 1) destination = 1000000
      end if
    end do
    a = links(cup3)
    c = links(destination)
    links(current)     = a
    links(destination) = cup1
    links(cup3)        = c

    current = nxt

  end do

  write(*,*) links(1)*links(links(1))

  end program prob23
