program prob16
   implicit none
   integer, parameter        :: charlen=36
   integer(kind=16)                   :: i, j, k, j1, k1, j2, k2, status, ioerror
   integer(kind=16)                   :: nvals1=0, nvals2=0, tval=0, err_rate
   integer(kind=16)                   :: csv, newind=0, prod
   character(len=charlen)         :: msg
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a, b, c
   character(len=80)                            :: line1, line2 
   logical                   :: ok
   integer(kind=16), allocatable, dimension(:) :: mins, maxs, ordering, ticket, x
   logical, allocatable, dimension(:,:) :: mask
   integer(kind=16), allocatable, dimension(:,:) :: positions


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
          ok = .false.
          do k = 1, size(mins)
            if (csv .ge. mins(k) .and. csv .le. maxs(k)) then
              ok = .true.
              csv = 0
            end if
          end do
          if (csv .ne. 0 .or. .not. ok) then
            b(i) = ''
          end if
          err_rate = err_rate + csv
          if (j == 0) exit
        end do tickvals
      end do nearby

      write(*,*) err_rate

      newind = 0
      do i = 1, nvals2
        line1 = b(i)
        if (line1 == '') then
          cycle
        else
          newind = newind + 1
        end if
      end do


      allocate( c(newind))
      allocate(positions(nvals1, nvals1))
      positions = 0
      j = 0
      do i = 1, nvals2
        line1 = b(i)
        if (line1 == '') then
          cycle
        else
          j = j + 1
          c(j) = b(i)
        end if
      end do




      tickind: do i = 1, newind
        line1 = c(i)
        tval = 0
        pos1: do
          tval = tval + 1
          j = index(line1, ',')
          if (j == 0) then
            read(line1, *) csv
          else
            read(line1(:j-1), *) csv
            line1 = line1(j+1:)
          end if
          pos2: do k = 2, size(mins), 2
            if ((csv .ge. mins(k-1) .and. csv .le. maxs(k-1)) .or. &
              & (csv .ge. mins(k) .and. csv .le. maxs(k))) then 
              positions(k/2, tval) = positions(k/2, tval) + 1
            end if
          end do pos2
          if (j == 0) exit
        end do pos1
      end do tickind


      do i = 1, nvals1
        ! write(*,fmt='(100I2)') positions(i,:)/newind
        ! if (minval(positions(i,:)) == 0) then
          ! write(*,*) c(i)
        ! end if
        positions(i,:) =  positions(i,:)/newind
        ! write(*,fmt='(100I2)') positions(i,:)
      end do

      allocate (mask(nvals1, nvals1))
      allocate (ordering(nvals1))
      allocate (ticket(nvals1))
      allocate (x(nvals1))


      ticket = [89, 179, 173, 167, 157, 127, 163, 113, 137, 109, 151, 131, 97, 149, 107, 83, 79, 139, 59, 53]
      mask = .true.

      prod = 1
      do i = 1, nvals1
        x = sum(positions, 1, mask)
        j =  minloc(x, 1, mask(1,:))
        k =  maxloc(positions(:, j), 1, mask(:, j))
        positions(k,:) = 0
        if (k < 7) then
          prod = prod*ticket(j)
        end if
        mask(:, j) = .false.
      end do

      write(*,*) prod

      
      
      
      if (allocated(a)) deallocate(a)
      if (allocated(b)) deallocate(b)
      if (allocated(mins)) deallocate(mins)
      if (allocated(maxs)) deallocate(maxs)
   else fileopen
      write(*,*) 'oops'
   end if fileopen

end program prob16
