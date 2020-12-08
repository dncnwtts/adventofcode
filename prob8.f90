program main
   implicit none
   integer                   :: i, j, k, l, status, ioerror
   integer                   :: ind=1, nvals=0, acc=0
   character(len=88)         :: msg
   character(len=10)         :: err_string
   character(len=88), allocatable, dimension(:) :: a, b
   integer, allocatable, dimension(:) :: counts

   open (unit = 9, file = 'data/input8.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat = status)
      allocate( counts(nvals) )
      counts = 0

      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)',iostat = status) a(i)
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen


   do
      counts(ind) = counts(ind) + 1
      if (counts(ind) > 1) exit
      if (index(a(ind), 'nop') .ne. 0) then
          ind = ind + 1
      else if (index(a(ind), 'acc') .ne. 0) then
          if (index(a(ind), '+').ne. 0) then
              k = index(a(ind), '+')
              read(a(ind)(k+1:),*) l
              acc = acc + l
          else if (index(a(ind), '-').ne. 0) then
              k = index(a(ind), '-')
              read(a(ind)(k+1:),*) l
              acc = acc - l
          end if
          ind = ind + 1
      else if (index(a(ind), 'jmp') .ne. 0) then
          if (index(a(ind), '+').ne. 0) then
              k = index(a(ind), '+')
              read(a(ind)(k+1:),*) l
              ind = ind + l
          else if (index(a(ind), '-').ne. 0) then
              k = index(a(ind), '-')
              read(a(ind)(k+1:),*) l
              ind = ind - l
          end if
      end if
   end do

   write(*,*) acc

   do j = 1, nvals
      b = a
      if (index(a(j), 'jmp') .ne. 0) then
          k = index(a(j), 'jmp')
          b(j)(k:k+3) = 'nop'
      else if (index(a(j), 'nop') .ne. 0) then
          k = index(a(j), 'nop')
          b(j)(k:k+3) = 'jmp'
      end if

      counts = 0
      ind = 1
      acc = 0
      do
         counts(ind) = counts(ind) + 1
         if (counts(ind) > 1) exit
         if (index(b(ind), 'nop') .ne. 0) then
             ind = ind + 1
         else if (index(b(ind), 'acc') .ne. 0) then
             if (index(b(ind), '+').ne. 0) then
                 k = index(b(ind), '+')
                 read(b(ind)(k+1:),*) l
                 acc = acc + l
             else if (index(b(ind), '-').ne. 0) then
                 k = index(b(ind), '-')
                 read(b(ind)(k+1:),*) l
                 acc = acc - l
             end if
             ind = ind + 1
         else if (index(b(ind), 'jmp') .ne. 0) then
             if (index(b(ind), '+').ne. 0) then
                 k = index(b(ind), '+')
                 read(b(ind)(k+1:),*) l
                 ind = ind + l
             else if (index(b(ind), '-').ne. 0) then
                 k = index(b(ind), '-')
                 read(b(ind)(k+1:),*) l
                 ind = ind - l
             end if
         end if
         if (ind == nvals+1) then
             write(*,*) acc
             exit
         end if
      end do
   end do



   if (allocated(a)) deallocate(a)

end program main
