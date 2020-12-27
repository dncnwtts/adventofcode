program main
   implicit none
   integer, parameter        :: tbl_length = 10000000, charlen=80
   integer(kind=16)                   :: i, j, k, j1, k1, j2, k2, status, ioerror
   integer(kind=16)                   :: nvals1=0, nvals2=0, tval=0, err_rate
   integer(kind=16)                   :: subject_number, card_public_key, loop_size_card
   integer(kind=16)                   :: door_public_key, loop_size_door
   integer(kind=16)                   :: val, buff, loop_size
   character(len=10)         :: err_string
   character(len=80), allocatable, dimension(:) :: a, b, c
   character(len=charlen)                            :: line1, line2 
   logical                   :: ok
   integer(kind=16), allocatable, dimension(:) :: mins, maxs, ordering, ticket, x
   logical, allocatable, dimension(:,:) :: mask
   integer(kind=16), allocatable, dimension(:,:) :: positions


   door_public_key = 10441485
   card_public_key = 1004920

   subject_number = 7

   loop_size_card = 0
   val = 1
   do 
     val = val * subject_number
     val = mod(val, 20201227)
     loop_size_card = loop_size_card + 1
     if (val == card_public_key) exit
   end do

   loop_size_door = 0
   val = 1
   do
     val = val * subject_number
     val = mod(val, 20201227)
     loop_size_door = loop_size_door + 1
     if (val == door_public_key) exit
   end do

   subject_number = door_public_key
   loop_size = loop_size_card

   val = 1
   do i=1, loop_size
     val = val * subject_number
     val = mod(val, 20201227)
   end do

   write(*,*) val

end program main
