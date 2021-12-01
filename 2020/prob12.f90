program prob12
   implicit none
   integer                   :: i, status=0, ioerror
   integer                   :: nvals=0
   real(8), parameter        :: pi = atan(1d0)*4
   real(8)                   ::  x, y, val, ang
   real(8)                   ::  x_wp, y_wp
   character(len=88)         :: msg
   character(len=10)         :: err_string
   character(len=88), allocatable, dimension(:) :: a
   character(len=88) :: line, dir
   integer, allocatable, dimension(:) :: counts

   open (unit = 9, file = 'data/input12.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat = status)
      allocate( counts(nvals) )
      counts = 0

      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)',iostat = status) a(i)
      end do
      x = 0
      y = 0
      ang = 0
      do i = 1, nvals
        line = a(i)
        read(line(2:),*) val
        dir = trim(line(1:1))
        if (dir == 'F') then
          x = x + val*cos(ang*pi/180)
          y = y + val*sin(ang*pi/180)
        else if (dir == 'N') then
          y = y + val
        else if (dir == 'S') then
          y = y - val
        else if (dir == 'E') then
          x = x + val
        else if (dir == 'W') then
          x = x - val
        else if (dir == 'R') then
          ang = ang - val
        else if (dir == 'L') then
          ang = ang + val
        end if
      end do

      write(*,*) nint(abs(x)+abs(y))


      x = 0
      y = 0
      x_wp = 10
      y_wp = 1
      ang = 0
      do i = 1, nvals
        line = a(i)
        read(line(2:),*) val
        dir = trim(line(1:1))
        if (dir == 'F') then
          x = x + val*x_wp
          y = y + val*y_wp
        else if (dir == 'N') then
          y_wp = y_wp + val
        else if (dir == 'S') then
          y_wp = y_wp - val
        else if (dir == 'E') then
          x_wp = x_wp + val
        else if (dir == 'W') then
          x_wp = x_wp - val
        else if (dir == 'R') then
          val = -1*val
          call rot_mat(x_wp, y_wp, val)
        else if (dir == 'L') then
          call rot_mat(x_wp, y_wp, val)
        end if
      end do


      write(*,*) nint(abs(x) + abs(y))


      if (allocated(a)) deallocate(a)
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   contains

     subroutine rot_mat(x, y, ang)
       real(8), intent(inout) :: x, y, ang
       real(8), dimension(2) :: v_in, v_out
       real(8), dimension(2, 2) :: R

       v_in = (/ x, y /)

       R(1, 1) = cos(ang*pi/180)
       R(1, 2) = -sin(ang*pi/180)
       R(2, 1) = sin(ang*pi/180)
       R(2, 2) = cos(ang*pi/180)

       v_out = matmul(R, v_in)

       x = v_out(1)
       y = v_out(2)

       end subroutine rot_mat



end program prob12
