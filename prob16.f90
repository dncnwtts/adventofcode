program main
   !use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=36
   integer                   :: i, j, k, j1, k1, j2, k2, status, ioerror
   integer                   :: nvals1=0, nvals2=0, m, n, err_rate
   integer                   :: csv
   character(len=:), allocatable :: out
   character(len=charlen)         :: msg
   character(len=charlen)         :: mask
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a, b
   character(len=80)                            :: line1, line2, line3, line4
   integer, allocatable, dimension(:) :: mins, maxs


   !type(dictionary_t) :: d

   !call d%init(tbl_length)



   open (unit = 8, file = 'data/input16_rules.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)
   open (unit = 9, file = 'data/input16_nearby.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(8, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals1 = nvals1 + 1
      end do
      allocate( a(nvals1), stat = status)
      if (status == 0) then
          rewind( unit = 8)
      else
          write(*,*) status
      end if
      do i = 1, nvals1
         read(8, '(A)', iostat = status) a(i)
      end do

      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals2 = nvals2 + 1
      end do
      allocate( b(nvals2), stat = status)
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals2
         read(9, '(A)', iostat = status) b(i)
      end do




      ! Get the ranges; should be ordered such that the valid values are
      ! mins(i) <= x <= maxs(i)

      allocate (mins(nvals1*2))
      allocate (maxs(nvals1*2))

      do i = 1, nvals1      
        line1 = a(i)
        j1 = index(line1, ':')
        k1 = index(line1, '-')
        line2 = line1(k1:)
        j2 = index(line2, '-')
        k2 = index(line2, ' ')
        read(line1(j1+1:k1-1), *) mins(2*i-1)
        read(line2(j2+1:k2-1), *) maxs(2*i-1)

        line1 = a(i)
        j1 = index(line1, ' or')
        line1 = line1(j1+3:)
        j1 = index(line1, ' ')
        k1 = index(line1, '-')
        line2 = line1(k1:)
        j2 = index(line2, '-')
        k2 = index(line2, ' ')
        read(line1(j1+1:k1-1), *) mins(2*i)
        read(line2(j2+1:k2-1), *) maxs(2*i)
      end do

      err_rate = 0
      nearby: do i = 1, nvals2
        line1 = b(i)
        tickvals: do
          j = index(line1, ',')
          if (j == 0) then
            read(line1, *) csv
          else
            read(line1(:j-1), *) csv
            line1 = line1(j+1:)
          end if
          do k = 1, size(mins)
            if (csv .ge. mins(k) .and. csv .le. maxs(k)) then
              !write(*,*) 'OK'
              csv = 0
            end if
          end do
          err_rate = err_rate + csv
          if (j == 0) exit
        end do tickvals
      end do nearby

      write(*,*) err_rate


      
      
      
      if (allocated(a)) deallocate(a)
      if (allocated(b)) deallocate(b)
      if (allocated(mins)) deallocate(mins)
      if (allocated(maxs)) deallocate(maxs)
   else fileopen
      write(*,*) 'oops'
   end if fileopen

end program main
