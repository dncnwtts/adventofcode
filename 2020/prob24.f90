program prob24
   implicit none
   integer, parameter        :: charlen=80
   integer(kind=16)          :: i, j, k, x, y, z, day, status=0, ioerror
   integer(kind=16)          :: nvals=0, num=0, lim=70
   character(len=charlen)    :: msg
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a
   character(len=charlen)    :: line
   integer(kind=16), allocatable, dimension(:,:,:) :: positions, positions_buff

   open (unit = 9, file = 'data/input24.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do
      allocate( a(nvals), stat = status)
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)', iostat = status) a(i)
      end do

      allocate(positions(-lim:lim, -lim:lim, -lim:lim))
      allocate(positions_buff(-lim:lim, -lim:lim, -lim:lim))
      positions = 0


      ! Hexagonal coordinate system, described in 
      ! https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/AV0405/MARTIN/Hex.pdf
      ! which follows
      ! Lee Middleton, Jayanthi Sivaswamy; Edge detection in a hexagonal-image processing framework; 
      ! Image and Vision Computing 19 (2201) 1071 –1081. 
      ! URL: http://www.ecs.soton.ac.uk/~ljm/archive/a_middleton2001edge.pdf
      do i = 1, nvals
        x = 0
        y = 0
        z = 0
        line = a(i)
        j = 1
        do
          if (line(j:j+1) == 'ne') then
            j = j + 2
            y = y + 1
            z = z + 1
          else if (line(j:j+1) == 'nw') then
            j = j + 2
            x = x - 1
            z = z + 1
          else if (line(j:j+1) == 'se') then
            j = j + 2
            x = x + 1
            z = z - 1
          else if (line(j:j+1) == 'sw') then
            j = j + 2
            y = y - 1
            z = z - 1
          else if (line(j:j) == 'e') then
            j = j + 1
            x = x + 1
            y = y + 1
          else if (line(j:j) == 'w') then
            j = j + 1
            x = x - 1
            y = y - 1
          else
            j = j + 1
          end if
          if (j == len(line)) exit
        end do
        if (positions(x,y,z) == 0) then
           positions(x,y,z) = 1
        else
           positions(x,y,z) = 0
        end if
      end do

      write(*,*) sum(positions)


      bigloop: do day = 1, 100

        positions_buff = positions

        do i = -lim+1, lim-1
          do j = -lim+1, lim-1
            do k = -lim+1, lim-1
              num = 0
              num = num + positions(i+1,j+1,k)
              num = num + positions(i-1,j-1,k)
              num = num + positions(i,j+1,k+1)
              num = num + positions(i,j-1,k-1)
              num = num + positions(i+1,j,k-1)
              num = num + positions(i-1,j,k+1)
              if (num == 0 .or. num > 2 .and. positions(i,j,k) == 1) then
                positions_buff(i,j,k) = 0
              else if (num == 2 .and. positions(i,j,k) == 0) then
                positions_buff(i,j,k) = 1
              end if
              if ((abs(k) == lim-1.or.abs(i)==lim-1.or.abs(j)==lim-1) .and. positions(i,j,k) == 1) then
                write(*,*) 'at the edge'
                exit bigloop
              end if
            end do
          end do
        end do
        positions = positions_buff
        if (day < 10 .or. mod(day,10_16) == 0) then
          write(*,*) day, sum(positions)
        end if
      end do bigloop




   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


end program prob24
