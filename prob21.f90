program main
   use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=200
   integer(kind=16)                   :: i, j, k, j1, k1, j2, k2, status, ioerror
   integer(kind=16)                   :: nvals1=0, nvals2=0, tval=0, num=0
   integer(kind=16)                   :: csv, newind=0, prod
   character(len=charlen)         :: msg, key, val
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

      call intersect(b(1), b(2), msg)
      write(*,*) b(1)
      write(*,*) b(2)
      write(*,*) msg
      call intersect(c(1), c(2), msg)
      write(*,*) c(1)
      write(*,*) c(2)
      write(*,*) msg



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

end program main
