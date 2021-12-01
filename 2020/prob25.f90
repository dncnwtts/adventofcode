program prob25
   implicit none
   integer(kind=16)                   :: i
   integer(kind=16)                   :: subject_number, card_public_key, loop_size_card
   integer(kind=16)                   :: door_public_key, loop_size_door
   integer(kind=16)                   :: val, loop_size


   door_public_key = 10441485
   card_public_key = 1004920

   subject_number = 7

   loop_size_card = 0
   val = 1
   do 
     val = val * subject_number
     val = mod(val, 20201227_16)
     loop_size_card = loop_size_card + 1
     if (val == card_public_key) exit
   end do

   loop_size_door = 0
   val = 1
   do
     val = val * subject_number
     val = mod(val, 20201227_16)
     loop_size_door = loop_size_door + 1
     if (val == door_public_key) exit
   end do

   subject_number = door_public_key
   loop_size = loop_size_card

   val = 1
   do i=1, loop_size
     val = val * subject_number
     val = mod(val, 20201227_16)
   end do

   write(*,*) val

end program prob25
