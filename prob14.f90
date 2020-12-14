program main
   use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=36
   integer(kind=16)                   :: i, j, k, status, ioerror
   integer(kind=16)                   :: nvals=0, m, n, maxmem=0, mem
   character(len=:), allocatable :: out
   character(len=charlen)         :: msg
   character(len=charlen)         :: mask
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a
   integer(kind=16), allocatable, dimension(:) :: addresses


   type(dictionary_t) :: d

   call d%init(tbl_length)



   open (unit = 9, file = 'data/input14.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do

      ! allocate memory
      allocate( a(nvals), stat = status)


      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)', iostat = status) a(i)
         if (index(a(i), 'mem') .ne. 0) then
           j = index(a(i), '[')
           k = index(a(i), ']')
           read(a(i)(j+1:k-1), *) mem
           if (mem > maxmem) then
             maxmem = mem
           end if
         end if
      end do

      allocate( addresses(maxmem) )
      addresses = 0

      do i = 1, nvals
        if (index(a(i), 'mask') .ne. 0) then
          mask = a(i)(8:)
        else
          j = index(a(i), '[')
          k = index(a(i), ']')
          read(a(i)(j+1:k-1), *) mem
          j = index(a(i), '=')
          read(a(i)(j+1:), *) m
          call mask_data(mask, m)
          addresses(mem) = m  
        end if
      end do

      write(*,*) sum(addresses)


      deallocate( addresses )


      ! Populate table
      do i = 1, nvals
        if (index(a(i), 'mask') .ne. 0) then
          mask = a(i)(8:)
        else
          j = index(a(i), '[')
          k = index(a(i), ']')
          read(a(i)(j+1:k-1), *) mem
          j = index(a(i), '=')
          read(a(i)(j+1:), *) m
          call memory_decode(mask, mem, m, d)
        end if
      end do

      ! Get sum of all allocated elements
      m = 0
      do i = 1, d%dict_size
        j = d%buckets(i)%current_idx
        if (j > 0) then
          do k = 1, j
            out = d%buckets(i)%entries(k)%value
            read(out, *) n
            m = m + n
          end do
        end if
      end do
      write(*,*) m


      if (allocated(a)) deallocate(a)
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   contains

   subroutine mask_data(mask, m)
     implicit none
     character(len=charlen), intent(in)     :: mask
     integer(kind=16), intent(inout) :: m
     integer(kind = 16) :: e
     character(len=charlen)         :: bin_repr

     integer :: i

     write(bin_repr, fmt='(B36)') m

     do i = 0, len(mask)
       if (mask(i:i) .ne. 'X') then
         bin_repr(i:i) = mask(i:i)
       else if (mask(i:i) .eq. 'X') then
         bin_repr(i:i) = bin_repr(i:i)
       else
         bin_repr(i:i) = '0'
       end if
     end do

     m = 0
     do i = 1, len(bin_repr)
       if (bin_repr(i:i) == '1') then
         e = 2
         e = e**(len(bin_repr)-i)
         m = m + e
       end if
     end do

     end subroutine mask_data


   subroutine memory_decode(mask, mem, val, d)
     implicit none
     character(len=charlen), intent(in)     :: mask
     type(dictionary_t), intent(inout)        :: d
     integer(kind=16), intent(inout) :: mem, val
     character(len=charlen)         :: bin_repr

     integer :: i

     write(bin_repr, fmt='(B36)') mem

     do i = 0, len(mask)
       if (mask(i:i) == '0') then
         bin_repr(i:i) = bin_repr(i:i)
       else if (mask(i:i) == '1') then
         bin_repr(i:i) = '1'
       else if (mask(i:i) == 'X') then
         bin_repr(i:i) = 'X'
       else
         bin_repr(i:i) = '0'
       end if
     end do

     call unfloat(bin_repr, d, val)

     end subroutine memory_decode


   recursive subroutine unfloat(bin_repr, addresses, val)
     character(len=charlen), intent(in)   :: bin_repr
     character(len=charlen)  :: b0, b1, tval, key
     integer(kind=16), intent(in) :: val

     type(dictionary_t), intent(inout)        :: addresses
     integer(kind=16) :: i
     integer(kind=16) :: e, m
     
     i = index(bin_repr, 'X')
     if (i == 0) then
       m = 0
       do i = 1, len(bin_repr)
         if (bin_repr(i:i) == '1') then
           e = 2
           e = e**(len(bin_repr)-i)
           m = m + e
         end if
       end do
       key = bin_repr
       do i = 1, len(bin_repr)
         if (bin_repr(i:i) == ' ') then
           key(i:i) = '0'
         end if
       end do
       write(tval, '(I20)') val
       write(key, '(I20)') m
       call addresses%set(key, tval)
     else
       b0 = bin_repr
       b1 = bin_repr
       b0(i:i) = '0'
       b1(i:i) = '1'
       call unfloat(b0, addresses, val)
       call unfloat(b1, addresses, val)
     end if


     end subroutine unfloat

end program main
