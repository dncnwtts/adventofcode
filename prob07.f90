program main
   use hashtbl
   implicit none
   integer, parameter        :: tbl_length = 1000, charlen=120
   integer                   :: i, j, k, status, ioerror, nvals=0, n=0, success=0
   character(len=charlen)         :: msg, container, line
   character(len=charlen)         :: bag,  bags
   character(len=charlen)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a
   character(len=charlen), allocatable, dimension(:) :: containers
   character(len=:), allocatable :: out
   
   type(hash_tbl_sll)        :: table


   call table%init(tbl_length)


   open (unit = 9, file = 'data/input7.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat = status)
      allocate( containers(nvals), stat = status)

      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)',iostat = status) a(i)
      end do

      do i = 1, nvals
          line = a(i)
          j = index(line, 'contain')
          k = index(line, 'bag')
          container = line(1:k-1)
          bags = line(j+len('contain'):)

          call table%put(key = trim(container), val = bags)
          containers(i) = container
      end do

      do i = 1, nvals
         call is_in_table(containers(i), table, n, success)
      end do
      write(*,*) n


      n = 0
      bag = 'shiny gold'
      call num_in_table(bag, table,  n)
      write(*,*) n


      if (allocated(a)) deallocate(a)

      call table%free
   else fileopen
      write(*,*) 'oops'
   end if fileopen

contains


    recursive subroutine is_in_table(bag, table, n_out, success)
        implicit none
        character(len=charlen), intent(in)    :: bag
        type(hash_tbl_sll), intent(in)        :: table
        integer, intent(inout) :: n_out
        integer, intent(out) :: success
        character(len=charlen)  :: bags=' ', container=' ', next
        character(len=:), allocatable :: out


        integer :: l, m

        success = 0

        if (trim(bag) == 'shiny gold') return

        call table%get(key = trim(bag), val = out)
        bags = out


        if  (index(bags, 'shiny gold') .ne. 0) then
            n_out = n_out + 1
            success = 1
        else
           do
               if (len(trim(bags)) == 0) exit
               if (index(bags, 'no other') .ne. 0) then
                   exit
               end if
               if (index(bags, 'shiny gold') .ne. 0) then
                   n_out = n_out + 1
                   success = 1
                   exit
               end if
               l = index(bags, ',')
               if (l .ne. 0) then
                   next = trim(bags(l+1:))
               else
                   next = ' '
               end if
               m = index(bags, 'bag')
               container = trim(bags(4:m-1))
               call is_in_table(container, table, n_out, success)
               if (success == 1) then
                   exit
               end if
               bags = next
           end do
        end if
    end subroutine is_in_table

    recursive subroutine num_in_table(bag, table, n_out)
        implicit none
        character(len=charlen), intent(in)    :: bag
        type(hash_tbl_sll), intent(inout)   :: table
        integer, intent(inout) :: n_out
        character(len=charlen)  :: bags=' ', container=' ', next
        character(len=:), allocatable :: out


        integer :: i, j, m, n, n_containers


        n_containers = 0




        call table%get(key = trim(bag), val = out)
        bags = out



        if (index(bags, 'no other') .eq.  0) then
           sub_bags: do
               m = 0
               if (len(trim(bags)) .eq. 0) exit
               i = index(bags, ',')
               if (i .ne. 0) then
                   next = trim(bags(i+1:))
               else
                   next = ' '
               end if
               j = index(bags, 'bag')
               container = trim(bags(4:j-1))
               read(bags(1:3),*) n
               call num_in_table(container, table, m)
               if (m == 0) then
                   n_out = n_out + n
               else
                   n_out = n_out + (m+1)*n
               end if
               bags = next
           end do sub_bags
       end if


    end subroutine num_in_table

end program main
