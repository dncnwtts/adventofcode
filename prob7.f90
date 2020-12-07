program main
   implicit none
   integer                   :: prod, i, j, k, l, status, ioerror, nvals=0, n=0
   character(len=88)         :: msg, container, contents
   character(len=88)         :: bag
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

   do i=1, nvals
       call is_in_tree(bag, i, a, baglist, n)
   end do
   write(*,*) n


   deallocate(a)

contains


    recursive subroutine is_in_tree(bag, start_int, a, baglist, n_out)
        implicit none
        character(len=88)             :: bag, bags
        integer, intent(in) :: start_int
        integer, intent(inout) :: n_out
        character(len=100000), intent(inout) :: baglist
        character(len=88)         :: msg, container, contents, line
        character(len=88), intent(in), dimension(:) :: a

        integer :: i, j, k, l, m, n

        line = a(start_int)
        write(*,*) bag
        !write(*,*) 'Searching for ', trim(bag)
        
        i = index(line, 'contain')
        container = line(1:i-2)
        bags = line(i+len('contain'):)
        !write(*,*) trim(container)
        !write(*,*) trim(bags)
        j = index(bags, 'no other')
        if (j .ne. 0) then
            !write(*,*) 'Found bottom'
            return
        end if
        k = index(bags, trim(bag))
        if (k .ne. 0) then
            !write(*,*) 'Found bag in question, in ', trim(container)
            n_out = n_out + 1
            return
        end if


        ! do loop here, exit when no commas are left.
        do
            l = index(bags, ',')
            if (l == 0) then
                m = index(bags, '     ')
                do n = start_int+1, nvals
                   call is_in_tree(bags(4:m-3), n, a, baglist, n_out)
                end do
                exit
            end if
            bags = bags(l+1:)

        end do

    end subroutine is_in_tree

end program main
