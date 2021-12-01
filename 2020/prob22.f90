program prob22
   use dictionary_m
   implicit none
   integer, parameter        :: charlen=80, tbl_length=1000
   integer                   :: i, j, k, l, sol, status, ioerror
   integer                   :: nvals=0
   character(len=charlen)    :: msg
   character(len=charlen)    :: err_string
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
      decknumber = 1
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

      sol = get_sol(deck_buff)
      write(*,*) sol


      call recursive_combat(deck1, deck2, deck_buff)


      sol = get_sol(deck_buff)
      write(*,*) sol

      deallocate( a, deck1, deck2 )

   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains

     subroutine combat(deck1, deck2, deck_buff)
       implicit none
       integer, dimension(:), intent(inout) :: deck1, deck2, deck_buff
       integer, allocatable, dimension(:) :: deck1_orig, deck2_orig
       integer :: c1, c2, num_iters
       integer, dimension(1) :: s

       s = shape(deck1, 1)

       allocate ( deck1_orig(s(1)) )
       allocate ( deck2_orig(s(1)) )

       deck1_orig = deck1
       deck2_orig = deck2

       num_iters = 0
       do
         num_iters = num_iters + 1
         c1 = deck1(1)
         c2 = deck2(1)
         if (c1 > c2) then
           deck_buff = deck1
           do i = 1, minloc(deck_buff, 1)
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
           do i = 1, minloc(deck_buff, 1)
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

         if (num_left(deck1) == 0) then
           deck_buff = deck2
           exit
         else if (num_left(deck2) == 0) then
           deck_buff = deck1
           exit
         end if
         if (num_iters == 1000) then
           deck_buff = deck1_orig
           exit
         end if
       end do
       deck1 = deck1_orig
       deck2 = deck2_orig
       end subroutine combat


     recursive subroutine recursive_combat(deck1, deck2, deck_buff)
       implicit none
       integer, dimension(:), intent(inout) :: deck1, deck2, deck_buff
       type(dictionary_t) :: dict
       integer, allocatable, dimension(:) :: deck1_orig, deck2_orig, deck1_rec, deck2_rec, deckb_rec
       integer :: c1, c2, num_iters, i, k
       integer, dimension(1) :: s
       character(len=3) :: tmp

       character(len=200) :: deck1_string, deck2_string
       character(len=200) :: deck_string

       logical :: p1_win

       call dict%init(tbl_length)

       deck1_string = ''
       deck2_string = ''
       deck_string = ''


       s = shape(deck1, 1)

       allocate ( deck1_orig(s(1)) )
       allocate ( deck2_orig(s(1)) )
       allocate ( deck1_rec(s(1)-1) )
       allocate ( deck2_rec(s(1)-1) )
       allocate ( deckb_rec(s(1)-1) )

       deck1_orig = deck1

       num_iters = 0

       do
         deck1_string = ''
         deck2_string = ''
         do k = 1, s(1)
           if (deck1(k) .ne. 0) then
             write(tmp, '(I2)') deck1(k)
             deck1_string = trim(deck1_string)//'a'//trim(adjustl(tmp))
           end if
           if (deck2(k) .ne. 0) then
             write(tmp, '(I2)') deck2(k)
             deck2_string = trim(deck2_string)//'b'//trim(adjustl(tmp))
           end if
         end do

         deck1_string = trim(deck1_string)//'a'
         deck2_string = trim(deck2_string)//'b'

         deck_string = trim(adjustl(deck1_string))//'y'//trim(adjustl(deck2_string))

         if (len(trim(dict%get(deck_string))) .ne. 0) then
           deck_buff = deck1
           exit
         end if

         call dict%set(deck_string, "1")

         num_iters = num_iters + 1
         c1 = deck1(1)
         c2 = deck2(1)
         if (num_left(deck1)-1 .ge. c1 .and. num_left(deck2)-1 .ge. c2) then
           deck1_rec = deck1(2:)
           deck2_rec = deck2(2:)
           deck1_rec(c1+1:) = 0
           deck2_rec(c2+1:) = 0
           deckb_rec = 0
           ! write(*,*) 'Recursing'
           call recursive_combat(deck1_rec, deck2_rec, deckb_rec)
           if (num_left(deck2_rec) == 0) then
             ! write(*,*) 'normal win'
             p1_win = .true.
           else if (num_left(deck1_rec) == 0) then
             ! write(*,*) 'normal win'
             p1_win = .false.
           else
             ! write(*,*) 'Found an infinite loop'
             p1_win = .true.
           end if
         else
           if (c1 > c2) then
             p1_win = .true.
           else
             p1_win = .false.
           end if
         end if
         if (p1_win) then
           deck_buff = deck1
           do i = 1, minloc(deck_buff, 1)
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
           do i = 1, minloc(deck_buff, 1)
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


         if (num_left(deck1) == 0) then
           deck_buff = deck2
           exit
         else if (num_left(deck2) == 0) then
           deck_buff = deck1
           exit
         end if

       end do

       end subroutine recursive_combat

    function num_left(deck) result(n)
      implicit none
      integer, dimension(:), intent(in) :: deck
      integer :: i, n

      n = 0

      do i = 1, size(deck, 1)
        if (deck(i) .ne. 0) n = n + 1
      end do

      end function

    function get_sol(deck) result(sol)
      implicit none
      integer, dimension(:), intent(in) :: deck
      integer :: i, n, sol
      integer, dimension(1) :: nvals

      nvals =  shape(deck, 1)

      sol = 0
      n = 1
      do i = nvals(1), 1, -1
        if (deck_buff(i) .ne.  0) then
          sol = sol + deck_buff(i)*n
          n = n + 1
        end if
      end do
      end function

end program prob22
