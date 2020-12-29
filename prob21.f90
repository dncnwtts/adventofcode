program main
   use LexicalSort
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=2000
   integer                            :: i, j, k, l, n, status, ioerror
   integer                            :: nvals1=0, nvals2=0, tval=0, num=0
   integer                            :: csv, newind=0, prod
   character(len=charlen)         :: msg, key, val, inter1, inter2, inter3, inter4
   character(len=10)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a, b, c
   character(len=charlen)                            :: line1, line2 
   logical                   :: ok
   integer,          allocatable, dimension(:) :: mins, maxs, ordering, ticket, x
   logical, allocatable, dimension(:,:) :: mask
   integer,          allocatable, dimension(:,:) :: positions

   character(len=charlen) :: dang_ingrs

   integer, parameter :: maxn = 10000, llen=60
   character(len=llen) :: lines_alls(maxn), lines_ingrs(maxn)
   integer :: idx(maxn)
   integer :: nlin

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

      do i = 1, nvals1
         read(9, '(A)', iostat = status) a(i)
         j = index(a(i), '(')
         k = index(a(i), ')')
         line1 = a(i)
         write(key, *) line1(:j-1)
         write(val, *) line1(j+9:k-1)
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


      n = 1

      do
        allergen: do i = 1, nvals1-1
          inter1 = b(i)
          inter2 = c(i)
          do j = i+1, nvals1
            call intersect(inter1, b(j), inter3)
            call intersect(inter2, c(j), inter4)

            if (count_strings(inter3) > 0 .and. count_strings(inter4)>0) then
              inter1 = inter3
              inter2 = inter4
            end if
            if (count_strings(inter1) == 1 .and. count_strings(inter2) == 1) then
              lines_ingrs(n) = trim(adjustl(inter1))
              lines_alls(n) = trim(adjustl(inter2))
              n = n + 1
              do k = 1, nvals1
                msg = b(k)
                l = index(msg, trim(adjustl(inter1)))
                if (l > 0) then
                  msg(l:l+len(trim(adjustl(inter1)))) = ' '
                  b(k) = msg
                end if

                msg = c(k)
                l = index(msg, trim(adjustl(inter2)))
                if (l > 0) then
                  msg(l:l+len(trim(adjustl(inter2)))) = ' '
                  c(k) = msg
                end if
              end do
              exit allergen
            end if
          end do
        end do allergen

        num = 0
        do i = 1, nvals1
          num = num + count_strings(c(i))
        end do
        if (num == 0) exit
      end do

      num = 0
      do i = 1, nvals1
        num = num + count_strings(b(i))
      end do

      write(*,*) num


      call sort(lines_alls(1:num), idx)

      j = 1
      dang_ingrs = ''
      do i = 1, num
        if (len(trim(adjustl(lines_ingrs(idx(i))))) .ne. llen) then
          dang_ingrs(j:j+len(trim(adjustl(lines_ingrs(idx(i)))))) = trim(adjustl(lines_ingrs(idx(i))))
          j = j + len(trim(adjustl(lines_ingrs(idx(i)))))
          if (i < num) then
            dang_ingrs(j:j) = ','
            j = j + 1
          end if
        end if
      end do
      write(*,*) trim(adjustl(dang_ingrs))






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
