program main
   use dictionary_m
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=36
   integer                   :: i, j, k
   character(len=charlen)         :: prev_val
   character(len=charlen)         :: say, turn


   type(dictionary_t) :: d

   call d%init(tbl_length)


   write(say,  *) 1
   write(turn, *) 1
   call d%set(say, turn)
   write(say,  *) 20
   write(turn, *) 2
   call d%set(say, turn)
   write(say,  *) 8
   write(turn, *) 3
   call d%set(say, turn)
   write(say,  *) 12
   write(turn, *) 4
   call d%set(say, turn)
   write(say,  *) 0
   write(turn, *) 5
   call d%set(say, turn)
   write(say,  *) 14
   write(turn, *) 6

   do i = 7, 2020
     ! write(*,*) say, turn
     prev_val = d%get(say)
     if (trim(prev_val) == '') then
       call d%set(say, turn)
       write(turn, *) i
       write(say,  *) 0
     else
       read(prev_val, *) k
       j = (i-1) - k
       call d%set(say, turn)
       write(turn, *) i
       write(say,  *) j
     end if
   end do

   write(*,*) trim(say)

   call d%init(tbl_length)


   write(*,*) 'Wait about one minute...'


   write(say,  *) 1
   write(turn, *) 1
   call d%set(say, turn)
   write(say,  *) 20
   write(turn, *) 2
   call d%set(say, turn)
   write(say,  *) 8
   write(turn, *) 3
   call d%set(say, turn)
   write(say,  *) 12
   write(turn, *) 4
   call d%set(say, turn)
   write(say,  *) 0
   write(turn, *) 5
   call d%set(say, turn)
   write(say,  *) 14
   write(turn, *) 6

   do i = 7, 30000000
     prev_val = d%get(say)
     if (trim(prev_val) == '') then
       call d%set(say, turn)
       write(turn, *) i
       write(say,  *) 0
     else
       read(prev_val, *) k
       j = (i-1) - k
       call d%set(say, turn)
       write(turn, *) i
       write(say,  *) j
     end if
     if (mod(i, 5000000) == 0) then
       write(*,*) turn, say
     end if
   end do

   write(*,*) trim(say)

end program main
