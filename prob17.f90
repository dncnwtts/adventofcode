program main
   implicit none
   integer, parameter        :: charlen=36
   integer                   :: i, j, x, y, z, w, status, ioerror
   integer                   :: nvals=0
   character(len=charlen)         :: msg
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a
   character(len=80)                            :: line1
   logical, dimension(-26:26,-26:26,-26:26) :: pocket, pocket_buff, pocket_orig
   logical, dimension(-26:26,-26:26,-26:26, -26:26) :: pocket4d, pocket_buff4d


   open (unit = 9, file = 'data/input17.txt', status = 'OLD', action = 'READ', &
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

      pocket = .false.

      do y = -nvals/2, nvals/2
        j = y + nvals/2+1
        line1 =  a(j)
        do x = -nvals/2, nvals/2
          i = x + nvals/2+1
          if (line1(i:i) == '#') then
            pocket(x, y, 0) = .true.
          end if
        end do
      end do

      pocket_buff = pocket
      pocket_orig = pocket

      do i = 1, 6
        ! compute new 
        do x = -25, 25
        do y = -25, 25
        do z = -25, 25
          nvals = check_cube(x, y, z, pocket_buff)
          if (pocket_buff(x, y, z)) then
            if (nvals .ne. 2 .and. nvals .ne. 3) then
              pocket(x, y, z) = .false.
            end if
          else
            if (nvals == 3) then
              pocket(x, y, z) = .true.
            end if
          end if
        end do
        end do
        end do

        pocket_buff = pocket
      end do


      nvals = 0
      do z = -26, 26
        do y = -26, 26
        do x = -26, 26
        if (pocket(x, y, z)) nvals = nvals + 1
        end do
        end do
      end do
      write(*,*) nvals


      pocket4d(:,:,:, 0) = pocket_orig

      pocket_buff4d = pocket4d

      do i = 1, 6
        ! compute new 

        do x = -25, 25
        do y = -25, 25
        do z = -25, 25
        do w = -25, 25
          nvals = check_cube4d(x, y, z, w, pocket_buff4d)
          if (pocket_buff4d(x, y, z, w)) then
            if (nvals .ne. 2 .and. nvals .ne. 3) then
              pocket4d(x, y, z, w) = .false.
            end if
          else
            if (nvals == 3) then
              pocket4d(x, y, z, w) = .true.
            end if
          end if
        end do
        end do
        end do
        end do

        pocket_buff4d = pocket4d
      end do


      nvals = 0
      do w = -26, 26
      do z = -26, 26
      do y = -26, 26
      do x = -26, 26
        if (pocket4d(x, y, z, w)) nvals = nvals + 1
      end do
      end do
      end do
      end do
      write(*,*) nvals


      if (allocated(a)) deallocate(a)
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   contains

     integer function check_cube(x, y, z, pocket)
             implicit none
             integer, intent(in) :: x, y, z
             logical, intent(in), dimension(-26:26,-26:26,-26:26) :: pocket

             integer :: xi, yi, zi

             check_cube = 0

             do xi = x-1, x+1
             do yi = y-1, y+1
             do zi = z-1, z+1
                if ((abs(xi-x) + abs(yi-y) + abs(zi-z) .ne. 0) .and. (pocket(xi, yi, zi))) then
                   check_cube = check_cube + 1
                end if
             end do
             end do
             end do

             return
             end function check_cube


     integer function check_cube4d(x, y, z, w, pocket)
             implicit none
             integer, intent(in) :: x, y, z, w
             logical, intent(in), dimension(-26:26,-26:26,-26:26,-26:26) :: pocket

             integer :: xi, yi, zi, wi

             check_cube4d = 0

             do xi = x-1, x+1
             do yi = y-1, y+1
             do zi = z-1, z+1
             do wi = w-1, w+1
                if ((abs(xi-x) + abs(yi-y) + abs(zi-z) +abs(wi-w) .ne. 0) .and. (pocket(xi, yi, zi, wi))) then
                   check_cube4d = check_cube4d + 1
                end if
             end do
             end do
             end do
             end do

             return
             end function check_cube4d

end program main
