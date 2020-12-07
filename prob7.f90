program main
   implicit none
   integer                   :: prod, i, j, k, l, status, ioerror, nvals=0, n=0
   character(len=88)         :: msg, container, contents
   character(len=88)         :: bag
   integer, dimension(26)    :: forms
   character(len=10)         :: err_string
   character(len=88), allocatable, dimension(:) :: a
   character(len=100000) :: baglist


    
   bag = 'shiny gold'
   do i = 1, len(baglist)
        baglist(i:i) = ' '
   end do

   open (unit=9, file='data/input7.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat=status)

      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i=1, nvals
         read(9, '(A)',iostat=status) a(i)
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen


   call traverse(bag, a, n, baglist)
   write(*,*) trim(baglist)
   write(*,*) n


   deallocate(a)

contains

    recursive subroutine traverse(bag, a, n, baglist)
        implicit none
        character(len=88)             :: bag
        character(len=88), intent(in), dimension(:) :: a
        character(len=88)         :: msg, container, contents
        integer, intent(inout) :: n
        character(len=100000), intent(inout) :: baglist

        integer :: nvals, i, j, k, l, m

        nvals = size(a)

        do k=1, nvals
           msg = a(k)
           i = index(msg, 'contain')
           j = index(msg(i+8:), trim(bag))
           container = msg(1:i-2)
           if (j > 0) then
               l = index(baglist, trim(container))
               !if (l == 0) then
                   m = index(baglist, '                   ')
                   baglist(m+2:m+len(trim(container))+2) = trim(container)
                   n = n + 1
               !end if
               call traverse(container, a, n, baglist)
           end if
        end do


    end subroutine traverse

end program main
