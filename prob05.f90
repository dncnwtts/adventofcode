program main
   implicit none
   integer, dimension(1000)  :: IDs=0
   integer, dimension(1024)  :: ID_inds=0
   integer                   :: status, ioerror, n=0
   character(len=10)         :: msg, err_string

   open (unit = 9, file = 'data/input5.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         n = n +1
         call binary_split(msg, IDs(n))
         ID_inds(IDs(n)) = IDs(n)
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   write(*,*) maxval(IDs)
   write(*,*) ID_inds

contains

   subroutine binary_split(msg, ID)
      implicit none
      character(len=10), intent(in)    :: msg
      integer,  intent(out) :: ID

      integer  :: i, row, column, min, max
      character(len=1)  :: c

      min = 0
      max = 128
      do i = 1, 6
         c = msg(i:i)
         if (c == 'B') then
            min = (max-min)/2 + min
         else if (c == 'F') then
            max = max - (max-min)/2
         end if
      end do
      if (msg(7:7) == 'F') then
         row = min
      else if (msg(7:7) == 'B') then
         row = max - 1
      end if

      min = 0
      max = 8
      do i = 7, 9
         c = msg(i:i)
         if (c == 'R') then
            min = (max-min)/2 + min
         else if (c == 'L') then
            max = max - (max-min)/2
         end if
      end do
      if (msg(10:10) == 'L') then
         column = min
      else if (msg(10:10) == 'R') then
         column = max - 1
      end if
      ID = row*8+column


   end subroutine binary_split


end program main
