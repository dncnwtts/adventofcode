program main
  implicit none
  integer, dimension(9) :: cups, remain, cups_buff
  integer, dimension(3) :: move
  integer :: i, j, k, current, current_ind, destination, destination_ind, moves



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
    !write(*,'(A,I3,A)') '-- move', i, ' --'
    ! At every step, rearrange so that the current cup lies at index 1.

    !write(*, '(A,I2)') 'current:', current

    !write(*,'(A,10I2)') 'cups:', cups


    move = cups(2:4)
    !write(*,'(A,10I2)') 'pick up:', move
    cups_buff = 0
    cups_buff(1) = cups(1)
    cups_buff(2:6) = cups(5:9)

    destination = mod(current - 1 + 9 -1, 9) + 1
    ! if destination is in the moved cups, subtract until it isn't
    do
      destination_ind = 0
      do j = 1, 3
        if (move(j) == destination) then
          destination_ind = j
        end if
      end do
      if (destination_ind .ne. 0) then
        destination = mod(destination - 1 + 9 - 1, 9) + 1
      else
        exit
      end if
    end do
    !write(*,'(A,I2)') 'destination:', destination

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

    !write(*,*)

  end do

  !write(*,'(A,10I2)') 'cups:', cups
  ! rearrange input so that 1 is the last index
  do i = 1, 9
    if (cups(i) == 1) then
      j = i
    end if
  end do
  cups_buff = cups
  do i = 1, 9
    cups(i) = cups_buff(mod(j+i-1,9)+1)
  end do
  write(*,'(8I1)') cups(1:8)

  end program main