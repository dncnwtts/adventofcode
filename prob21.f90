program main
   use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=1000
   integer(kind=16)                   :: i, j, k, l, status, ioerror
   integer(kind=16)                   :: nvals1=0, nvals2=0, tval=0, num=0
   integer(kind=16)                   :: csv, newind=0, prod
   character(len=charlen)         :: msg, key, val, inter1, inter2
   character(len=10)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a, b, c
   character(len=charlen)                            :: line1, line2 
   logical                   :: ok
   integer(kind=16), allocatable, dimension(:) :: mins, maxs, ordering, ticket, x
   logical, allocatable, dimension(:,:) :: mask
   integer(kind=16), allocatable, dimension(:,:) :: positions

   type(dictionary_t) :: d

   call d%init(tbl_length)


   open (unit = 9, file = 'data/input21.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals1 = nvals1 + 1
      end do
      allocate( a(nvals1), stat = status)
      allocate( b(nvals1), stat = status)
      allocate( c(nvals1), stat = status)
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if

      ! initialize dictionary
      do i = 1, nvals1
         read(9, '(A)', iostat = status) a(i)
         j = index(a(i), '(')
         k = index(a(i), ')')
         line1 = a(i)
         write(key, *) line1(:j-1)
         !j = index(a(i), 'contains ')
         write(val, *) line1(j+9:k-1)
         !key = trim(adjustl(key))
         !val = trim(adjustl(val))
         !call d%set(key, val)
         b(i) = key
         c(i) = val
      end do

      do i = 1, nvals1
        do j = 1, len(c(i))
          msg = c(i)
          if (msg(j:j) == ',') msg(j:j) = ' '
          c(i) = msg
        end do
      end do


      ! To find an allergen, take the intersection of two sets. If there is a one-to-one
      ! allergence-ingredient list, then remove that from all others. You are not modifying
      ! the ingredient / allergen list unless you found the one-to-one.

      ! We'll implement what I did in LaTeX so I can do it pedantically, then we
      ! can do it more programatically.
      do i = 1, nvals1
        write(*,*) trim(adjustl(b(i))), '   ', trim(adjustl(c(i)))
      end do

      do i = 1, nvals1-1
        do j = i+1, nvals1
          call intersect(b(i), b(j), inter1)
          call intersect(c(i), c(j), inter2)

          if (count_strings(inter1) == 1 .and. count_strings(inter2) == 1) then
            do k = 1, nvals1
              l = index(b(k), trim(adjustl(inter1)))
              if (l > 0) then
                msg = b(k)
                msg(l:l+len(trim(adjustl(inter1)))) = ' '
                b(k) = msg
              end if
              l = index(c(k), trim(adjustl(inter2)))
              if (l > 0) then
                msg = c(k)
                msg(l:l+len(trim(adjustl(inter2)))) = ' '
                c(k) = msg
              end if
            end do
          end if
        end do
      end do

      do i = 1, nvals1
        if (count_strings(c(i)) == 1) then
          do j = 1, nvals1
            call intersect(b(i), b(j), inter1)
            call intersect(c(i), c(j), inter2)
            l = index(b(j), trim(adjustl(inter1)))
            if (l > 0) then
              msg = b(j)
              msg(l:l+len(trim(adjustl(inter1)))) = ' '
              b(j) = msg
            end if
            l = index(c(j), trim(adjustl(inter2)))
            if (l > 0) then
              msg = c(j)
              msg(l:l+len(trim(adjustl(inter2)))) = ' '
              c(j) = msg
            end if
          end do
        end if
      end do

      write(*,*)
      do i = 1, nvals1
        if (count_strings(b(i)) > 0) then
          write(*,*) trim(adjustl(b(i))), '   ', trim(adjustl(c(i)))
        end if
      end do
      write(*,*)

      num = 0
      do i = 1, nvals1
        num = num + count_strings(b(i))
      end do

      write(*,*) num






   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen

   contains

     subroutine intersect(a, b, c)
       implicit none
       character(len=charlen), intent(in)  :: a, b
       character(len=charlen), intent(out) :: c


       integer :: i, j, k, l


       c = a
       do i = 1, len(c)
         if (c(i:i) == ' ') cycle
         j = index(c(i:), ' ') + i
         k = index(b, c(i:j-1))
         if (k == 0) then
           c(i:j-1) = ' '
         end if
       end do



       end subroutine intersect


    function count_strings(a) result(num)
      implicit none
       character(len=charlen), intent(in)  :: a

       integer :: num
       integer :: i, j, k


       ! loop over string
       ! if you find a character, search for the next space
       i = 1
       num = 0
       do
         if (a(i:i) == ' ') then
           i = i + 1
         else
           i = index(a(i:), ' ') + i
           num = num + 1
         end if
         if (i == len(a)) exit
       end do


      end function count_strings

end program main
