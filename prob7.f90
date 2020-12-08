program main
   use hashtbl
   implicit none
   integer                   :: prod, i, j, k, l, status, istat, ioerror, nvals=0, n=0
   character(len=88)         :: msg, container, contents, line
   character(len=88)         :: bag, root, bags
   character(len=10)         :: err_string
   character(len=88), allocatable, dimension(:) :: a
   character(len=88), allocatable, dimension(:) :: containers
   character(len=100000) :: baglist
   character(len=:), allocatable :: out
   
   type(hash_tbl_sll)        :: table
   integer, parameter        :: tbl_length = 1000


   call table%init(tbl_length)


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

      end do

      ! allocate memory
      allocate( a(nvals), stat=status)
      allocate( containers(nvals), stat=status)

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
       !write(*,*) a(i), i, nvals
       !call is_in_tree(bag, a(i), i, a, baglist, n)
       line = a(i)
       j = index(line, 'contain')
       k = index(line, 'bag')
       container = line(1:k-1)
       bags = line(j+len('contain'):)
       call table%put(key=trim(container), val=bags)

       containers(i) = container

       call table%get(key=trim(container), val=out)
       write(*,*) trim(container)
       write(*,*) out
   end do
   write(*,*) n


   do i =1, nvals
      call is_in_table(containers(i), table, n)
   end do


   if (allocated(a)) deallocate(a)

   call table%free

contains


    recursive subroutine is_in_table(bag, table, n_out)
        implicit none
        character(len=88), intent(in)    :: bag
        type(hash_tbl_sll), intent(in)   :: table
        integer, intent(inout) :: n_out
        character(len=88)  :: bags, msg, container, contents, line
        character(len=:), allocatable :: out

        integer :: i, j, k, l, m, n

        write(*,*) 't6', bag
        write(*,*) 't7', ' calling table ', trim(bag)
        call table%get(key=trim(bag), val=out)
        write(*,*) trim(bag), out

        j = index(out, 'no other')
        if (j .ne. 0) then
            write(*,*) 'Found no shiny golds'
            return
        end if
        j = index(out, 'shiny gold')
        if (j .ne. 0) then
            n = n + 1
            write(*,*) 'Found one!'
            return
        end if

        do
            l = index(out, ',')
            m = index(out, 'bag')
            write(*,*) 't1',out(3:m-1)
            if (l == 0) then
                m = index(out, 'bag')
                bags = out(3:m-1)
                write(*,*) 't3',bags
                call is_in_table(bags, table, n_out)
                exit
            else
                write(*,*) 't4', out(1:l-1), out(l+1:)
                m = index(out(1:l), 'bag')
                bags = trim(out(3:m-1))
                write(*,*) 't5', bags
                call is_in_table(bags, table, n_out)
                out = out(l+1:)
            end if

        end do

        
    end subroutine is_in_table

end program main
