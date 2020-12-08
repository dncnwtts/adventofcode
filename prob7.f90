program main
   implicit none
   integer                   :: prod, i, j, k, l, status, istat, ioerror, nvals=0, n=0
   character(len=88)         :: msg, container, contents, line
   character(len=88)         :: bag, root, bags
   character(len=10)         :: err_string
   character(len=88), allocatable, dimension(:) :: a
   character(len=100000) :: baglist

   type :: node
       character(len=88) :: v
       type (node), pointer  :: p
   end type

   type(node), pointer :: head, ptr, tail

   bag = 'shiny gold'
   do i = 1, len(baglist)
        baglist(i:i) = ' '
   end do

   open (unit=9, file='data/dummy_input7.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (status /= 0) exit
         nvals = nvals + 1

         if (.not. associated(head)) then
             write(*,*) 'ok'
             allocate (head)
             tail => head
             nullify (tail%p)
             tail%v = msg
         else 
             write(*,*) 'not ok'
             allocate (tail%p)
             tail => tail%p
             nullify (tail%p)
             tail%v = msg
         end if
      end do

      ptr => head
      output: do
        if (.not. associated(ptr)) exit
        write (*,*) ptr%v
        ptr => ptr%p
      end do output

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

   line = a(1)
   i = index(line, 'contain')
   container = line(1:i-2)
   bags = line(i+len('contain'):)

   do i=1, nvals
       !write(*,*) a(i), i, nvals
       call is_in_tree(bag, a(i), i, a, baglist, n)
   end do
   !write(*,*) trim(baglist)
   write(*,*) n


   if (allocated(a)) deallocate(a)

contains


    recursive subroutine is_in_tree(bag, root, start_int, a, baglist, n_out)
        implicit none
        character(len=88)             :: bag, root, bags
        integer, intent(in) :: start_int
        integer, intent(inout) :: n_out
        character(len=100000), intent(inout) :: baglist
        character(len=88)         :: msg, container, contents, line
        character(len=88), intent(in), dimension(:) :: a

        integer :: i, j, k, l, m, n

        line = a(start_int)
        
        i = index(line, 'contain')
        container = line(1:i-2)
        bags = line(i+len('contain'):)
        !write(*,*) trim(container)
        !write(*,*) trim(bags)
        j = index(bags, 'no other')
        if (j .ne. 0) then
            return
        end if
        k = index(bags, trim(bag))
        if (k .ne. 0) then
            !write(*,*) 'Found ', trim(bag), ' in question, in ', trim(container), trim(root)
            ! Update baglist
            l = index(baglist, trim(root))
            if (l == 0) then
                l = index(baglist, '       ')
                baglist(l+1:len(trim(root))+l+1) = trim(root)
                n_out = n_out + 1
            end if
            return
        end if


        ! do loop here, exit when no commas are left.
        do
            l = index(bags, ',')
            !write(*,*) trim(bags(:l-1)), trim(bags(l+1:))
            if (l == 0) then
                m = index(bags, '     ')
                do n = start_int+1, nvals
                   call is_in_tree(bag, root, n, a, baglist, n_out)
                end do
                exit
            else
                bags = bags(l+1:)
            end if

        end do

    end subroutine is_in_tree

end program main
