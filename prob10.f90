program main
   use sorts
   implicit none
   integer                   :: i, j, k, l, buff, status, ioerror, answer1
   integer                   :: nvals=0, jumps1=0, jumps3=0, n=0, m=0
   character(len=88)         :: msg
   character(len=10)         :: err_string
   integer, allocatable, dimension(:) :: a,b,jumps

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


      deallocate(a)

   else fileopen
      write(*,*) 'file not opening'
   end if fileopen

end program main
