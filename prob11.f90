program main
  implicit none
  integer                   :: i, j, status, ioerror, nvals=0, ans=0, leng
  character(len=88)         :: msg
  character(len=10)         :: err_string
  character(len=98),  allocatable, dimension(:)   :: a
  character(len=98), allocatable, dimension(:,:) :: b, c
  character(len=98) :: buff
  integer, allocatable, dimension(:,:) :: neighbors

  open (unit = 9, file = 'data/input11.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

  fileopen: if (ioerror == 0) then
    do
      read(9, '(A)', iostat = status) msg
      if (status /= 0) exit
      nvals = nvals + 1
    end do

    ! allocate memory
    allocate( a(nvals), stat = status)
    if (status == 0) then
      rewind( unit = 9)
    else
      write(*,*) status
    end if

    do i = 1, nvals
      read(9, '(A)', iostat = status) a(i)
      write(*,*) a(i)
    end do

    leng = len(a(1))
    allocate( b(0:nvals+1, 0:leng+1), stat = status)
    allocate( c(0:nvals+1, 0:leng+1), stat = status)
    allocate( neighbors(nvals, leng), stat = status)

    b = '.'
    c = '.'

    neighbors = 0

    do i = 1, nvals
      buff = a(i)
      do j = 1, len(a(1))
        b(i,j) = buff(j:j)
      end do
    end do

    b = transpose(b)
    write(*, fmt='(100A1)') b


    do
      c = b

      forall (i=1:nvals, j=1:leng, b(i,j) .eq. 'L' .and. neighbors(i,j) .eq. 0)
        c(i,j) = '#'
      end forall
      forall (i=1:nvals, j=1:leng, b(i,j) .eq. '#' .and. neighbors(i,j) .ge. 4)
        c(i,j) = 'L'
      end forall

      neighbors = 0
      do i=1, nvals
        do j=1, leng
          if (c(i-1,j+1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i,  j+1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i+1,j+1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i+1,j  ) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i+1,j-1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i  ,j-1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i-1,j-1) == '#') neighbors(i,j) = neighbors(i,j) + 1
          if (c(i-1,j  ) == '#') neighbors(i,j) = neighbors(i,j) + 1
        end do
      end do
      write(*, fmt='(98A1)') c(1:leng,1:leng)
      write(*,*) 
      !write(*, fmt='(100I1)') neighbors

      if (all(c .eq. b)) then
        write(*,*) 'we are done'
        do i = 1, nvals
          do j = 1, leng
            if (b(i,j) == '#') then
              ans = ans + 1
            end if
          end do
        end do
        write(*,*) ans
        exit
      else 
        b = c
      end if
    end do


    deallocate(a, b, c,neighbors)

  else fileopen
    write(*,*) 'file not opening'
  end if fileopen

end program main
