program main
   use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=80
   integer(kind=16)                   :: i, j, k, j1, k1, j2, k2, status, ioerror
   integer(kind=16)                   :: nvals1=0, nvals2=0, tval=0, num=0
   integer(kind=16)                   :: csv, newind=0, prod
   character(len=charlen)         :: msg, key, val
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a, b, c
   character(len=charlen)                            :: line1, line2 
   logical                   :: ok
   integer(kind=16), allocatable, dimension(:) :: mins, maxs, ordering, ticket, x
   logical, allocatable, dimension(:,:) :: mask
   integer(kind=16), allocatable, dimension(:,:) :: positions

   type(dictionary_t) :: d

   call d%init(tbl_length)


   open (unit = 8, file = 'data/input19_rules.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)
   open (unit = 9, file = 'data/input19_messages.txt', status = 'OLD', action = 'READ', &
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

      ! initialize dictionary
      do i = 1, nvals1
         read(8, '(A)', iostat = status) a(i)
         j = index(a(i), ':')
         line1 = a(i)
         write(key, *) line1(:j-1)
         write(val, *) line1(j+1:)
         key = trim(adjustl(key))
         val = trim(adjustl(val))
         call d%set(key, val)
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

      ! read in messages
      do i = 1, nvals2
         read(9, '(A)', iostat = status) b(i)
      end do

      num = 0
      key = "0"
      do i = 1, nvals2
        if (is_valid(b(i), d, key)) num = num+1
      end do
      write(*,*) num
      ! should be 2

   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains

     recursive function is_valid(m, d, key) result(res)
       use dictionary_m
       implicit none
       type(dictionary_t),     intent(in) :: d
       character(len=charlen), intent(in)  :: m
       character(len=charlen), intent(in)  :: key
       logical :: res

       integer :: i

       res = .false.
       ! My thoughts on how to do this...

       ! Loop through the characters in the message, e.g., aab

       ! My thought for the algorithm is... evaluate the key, always choose the first element.
       ! If the first element doesn't match, then it's a failure, go up a level, look for a bar, try next el after the bar.


       end function is_valid

     recursive subroutine traverse(d, key, val)
       use dictionary_m
       implicit none

       type(dictionary_t), intent(inout)   :: d
       character(len=charlen), intent(in)  :: key
       character(len=charlen), intent(out) :: val

       logical :: pipe

       character(len=charlen)  :: k, l, m


       integer :: ind

       ind = 1

       val = ''

       if (index(key, '|') > 0) then
         pipe = .true.
         val(ind:ind) = '('
         ind = ind + 1
       else
         pipe = .false.
       end if

       do i = 1, len(trim(key))
         k = trim(adjustl(key(i:i)))
         l = trim(adjustl(d%get(k)))
         if (l == '"a"' .or. l == '"b"') then
           val(ind:ind) = l(2:2)
           ind = ind + 1
         else if (k == '|') then
           val(ind:ind) = '|'
           ind = ind + 1
         else if (k == ')') then
           cycle
         else if (l .ne. ' ') then
           call traverse(d, l, m)
           m = trim(adjustl(m))
           val(ind:ind+len(m)) = m
           ind = ind + len(m) + 1
         end if
       end do

       if (pipe) then
         val(ind:ind) = ')'
       end if

       end subroutine traverse


end program main
