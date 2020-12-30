program main
   implicit none
   integer, parameter        :: charlen=80, lim=70
   integer                   :: i, j, k, l, n, sol, status, ioerror
   integer                   :: nvals=0, r=0
   character(len=charlen)    :: msg
   character(len=charlen)    :: err_string, line
   character(len=80), allocatable, dimension(:) :: a
   integer, allocatable, dimension(:) :: deck1, deck2, deck_buff

   integer :: decknumber

   open (unit = 9, file = 'data/input22.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do
      allocate( a(nvals), stat = status)
      allocate( deck1(nvals), stat = status)
      allocate( deck2(nvals), stat = status)
      allocate( deck_buff(nvals), stat = status)
      deck1 = 0
      deck2 = 0
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      k = 1
      l = 1
      do i = 1, nvals
         read(9, '(A)', iostat = status) a(i)
         j = index(a(i), 'Player 1')
         if (j > 0) then
           decknumber = 1
           cycle
         end if

         j = index(a(i), 'Player 2')
         if (j > 0) then
           decknumber = 2
           cycle
         end if

         if (len(trim(a(i))) == 0) cycle
         if (decknumber == 1) then
           read(a(i), *) deck1(k)
           k = k + 1
         end if
         if (decknumber == 2) then
           read(a(i), *) deck2(l)
           l = l + 1
         end if
      end do

      call combat(deck1, deck2, deck_buff)

      sol = 0
      n = 1
      do i = nvals, 1, -1
        if (deck_buff(i) .ne.  0) then
          sol = sol + deck_buff(i)*n
          n = n + 1
        end if
      end do
      write(*,*) sol

      deallocate( a, deck1, deck2 )

   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains

     subroutine combat(deck1, deck2, deck_buff)
       implicit none
       integer, dimension(:), intent(Inout) :: deck1, deck2, deck_buff
       do
         if (deck1(1) > deck2(1)) then
           deck_buff = deck1
           do i = 1, minloc(deck_buff,1)
             deck_buff(i) = deck1(i+1)
           end do
           deck_buff(i-2) = deck1(1)
           deck_buff(i-1) = deck2(1)
           deck1 = deck_buff
           
           deck_buff = deck2
           do i = 1, minloc(deck_buff, 1)
             deck_buff(i) = deck2(i+1)
           end do
           deck_buff(i+1) = 0
           deck2 = deck_buff
         else
           deck_buff = deck2
           do i = 1, minloc(deck_buff,1)
             deck_buff(i) = deck2(i+1)
           end do
           deck_buff(i-2) = deck2(1)
           deck_buff(i-1) = deck1(1)
           deck2 = deck_buff
           
           deck_buff = deck1
           do i = 1, minloc(deck_buff, 1)
             deck_buff(i) = deck1(i+1)
           end do
           deck_buff(i+1) = 0
           deck1 = deck_buff
         end if

         if (maxval(deck1) == 0) then
           deck_buff = deck2
           exit
         else if (maxval(deck2) == 0) then
           deck_buff = deck1
           exit
         end if
       end do
       end subroutine combat


end program main
