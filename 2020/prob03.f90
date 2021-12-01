program prob03
   implicit none
   integer                   :: num=0
   character(len=31)         :: msg


   open (unit=9, file='data/input3.txt', status='OLD', action='READ')
   ! call get_hits(1, 1, num)
   ! write(*,*) num

   ! call get_hits(3, 1, num)
   ! write(*,*) num

   ! call get_hits(5, 1, num)
   ! write(*,*) num

   ! call get_hits(7, 1, num)
   ! write(*,*) num

   call get_hits(1, 2, num)
   write(*,*) num

   close (unit = 9)

contains

   subroutine get_hits(right, down, num)
        integer, intent(in)  :: right, down
        integer, intent(out) :: num
        integer              :: i, j, status=0
        character(len=1)     :: c

        num = 0
        i = 1
        j = 1
        fileopen: if (status == 0) then
           do
              read(9, '(A)', iostat = status) msg
              if (status /= 0) exit
              if (mod(i, down) == 1 .or. down == 1) then
                 c = msg(j:j)
                 if (c == '#') then
                    num = num + 1
                 end if
                 j = mod(j + right -1, 31) + 1
              end if
              i = i + 1
           end do
        else fileopen
           write(*,*) 'oops', status
        end if fileopen

        rewind(9)
   end subroutine get_hits


end program prob03
