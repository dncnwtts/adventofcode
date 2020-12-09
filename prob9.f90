program main
   implicit none
   integer                   :: i, j, k, l, buff, status, ioerror, answer1
   integer                   :: nvals=0
   character(len=88)         :: msg
   character(len=10)         :: err_string
   integer, allocatable, dimension(:) :: a
   integer, allocatable, dimension(:) :: counts

   open (unit = 9, file = 'data/input9.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat = status)
      allocate( counts(nvals), stat = status)
      counts = 0
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, *, iostat = status) a(i)
      end do

      buff = 25
      do i=buff+1, nvals
          do j=i-buff, i-1
              do k=j+1, i-1
                  if (a(i) ==  a(j)+a(k)) then
                      counts(i) = 1
                  end if
              end do
          end do
      end do

      l = minloc(counts(buff+1:), 1)+buff
      answer1 = a(l)
      write(*,*) answer1


      outer: do j=1, l
          do k=j+1, l
              if (sum(a(j:k)) == answer1) then
                  write(*,*) minval(a(j:k)) + maxval(a(j:k))
                  exit outer
              end if
          end do
      end do outer


      deallocate(a, counts)

   else fileopen
      write(*,*) 'file not opening'
   end if fileopen

end program main
