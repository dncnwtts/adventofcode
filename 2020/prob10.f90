program prob10
   use sorts
   implicit none
   integer                   :: i, status=0, ioerror
   integer                   :: nvals=0, jumps1=0, jumps3=0, n=0, m=0
   character(len=88)         :: msg
   character(len=10)         :: err_string
   integer, allocatable, dimension(:) :: a, jumps

   open (unit = 9, file = 'data/input10.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(0:nvals+1), stat = status)
      allocate( jumps(nvals+1), stat = status)
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      a(0) = 0
      do i = 1, nvals
         read(9, *, iostat = status) a(i)
      end do
      a(nvals+1) = maxval(a) + 3


      call quicksort(a)


      do i = 1, nvals+1
        jumps(i) = a(i) - a(i-1)
        if (jumps(i) .eq. 1) then
          jumps1 = jumps1 + 1
        else if (jumps(i) .eq. 3) then
          jumps3 = jumps3 + 1
        end if
      end do

      write(*,*) jumps1*jumps3


      m = 1
      n = 1
      do i = 1, nvals+1
        if (jumps(i) == 3) then
          if (i-m > 1) then
            ! write(*,*) jumps(m:i)
            print "(8i1)", jumps(m:i)
          end if
          m = i+1
        end if
      end do

      write(*,*) 

      write(*,*) 'There is a code of differences: 11113 -> 7, 1113 -> 4, 113 -> 2'
      write(*,*) 'Multiply these all together to get the answer.'


      deallocate(a)

   else fileopen
      write(*,*) 'file not opening'
   end if fileopen

end program prob10
