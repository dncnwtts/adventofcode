program main
   implicit none
   integer, parameter        :: charlen=80, lim=70
   integer                   :: i, j, k, l, n, status, ioerror
   integer                   :: nvals=0, num=0, ntiles=0
   integer(kind=16)          :: csv, newind=0, prod
   character(len=charlen)    :: msg
   character(len=10)         :: err_string, line
   character(len=80), allocatable, dimension(:) :: a, b, c
   character(len=1), allocatable, dimension(:,:,:) :: tiles
   character(len=1), dimension(10,10) :: tile_buff
   logical                   :: ok
   integer, allocatable, dimension(:) :: tile_IDs
   integer, allocatable, dimension(:) :: num_matches

   open (unit = 9, file = 'data/input20.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
      do
         read(9, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do
      allocate( a(nvals), stat = status)
      if (status == 0) then
          rewind( unit = 9)
      else
          write(*,*) status
      end if
      do i = 1, nvals
         read(9, '(A)', iostat = status) a(i)
         if (index(a(i), 'Tile') .ne. 0) ntiles = ntiles + 1
      end do

      allocate( tile_IDs(ntiles) )
      allocate( num_matches(ntiles) )
      allocate( tiles(ntiles, 10, 10))
      ntiles = 0
      j = 0
      do i = 1, nvals
         if (index(a(i), 'Tile') .ne. 0) then
           msg = a(i)
           j = index(msg, 'e')
           k = index(msg, ':')
           ntiles = ntiles + 1
           read(msg(j+1:k-1),*) tile_IDs(ntiles)
           j = 0
         else if (len(trim(a(i))) == 0) then
           cycle
         else
           j = j + 1
           msg = a(i)
           line = trim(msg)
           do k = 1, 10
             tiles(ntiles,j,k) = line(k:k)
           end do
         end if
      end do


      tiles(1,:,:) = flip_hor(tiles(1,:,:))

      num_matches = 0
      do k = 1, ntiles
        do l = 1, ntiles
          i = 0
          j = 0
          call check_all_matches(tiles(k,:,:), tiles(l,:,:), i, j)
          if (i .ne. 0 .or. j .ne. 0) then
            num_matches(k) = num_matches(k) + 1
          end if
        end do
      end do

      n = minval(num_matches)

      prod = 1
      do i = 1, ntiles
        if (num_matches(i) == n) then
          prod = prod * tile_IDs(i)
        end if
      end do

      write(*,*) prod

      deallocate( a, tile_IDs, tiles )

   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains

     subroutine check_match(tile1, tile2, i, j)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile1
       character(len=1), intent(in), dimension(10,10) :: tile2
       integer, intent(out) :: i, j

       if (all(tile1(1, :) == tile2(10, :))) then
         i = 0
         j = 1
       else if (all(tile1(:, 1) == tile2(:,10))) then
         i = -1
         j = 0
         return
       else if (all(tile1(10,:) == tile2(1, :))) then
         i = 0
         j = -1
         return
       else if (all(tile1(:,10) == tile2(:,1))) then
         i = 1
         j = 0
         return
       end if

       end subroutine check_match

     subroutine check_all_matches(tile1, tile2, i, j)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile1
       character(len=1), intent(inout), dimension(10,10) :: tile2
       character(len=1), dimension(10,10) :: tile_buff, tile_buff2
       integer, intent(out) :: i, j

       i = 0
       j = 0

       call check_match(tile1, tile2, i, j)
       tile_buff = flip_ver(tile2)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       call check_match(tile1, tile_buff, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff = rot90(tile2)
       call check_match(tile1, tile_buff, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff = rot180(tile2)
       call check_match(tile1, tile_buff, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff = rot270(tile2)
       call check_match(tile1, tile_buff, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if

       tile_buff = flip_ver(tile2) 
       call check_match(tile1, tile_buff, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff2 =  rot90(tile_buff)
       call check_match(tile1, tile_buff2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff2 = rot180(tile_buff)
       call check_match(tile1, tile_buff2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if
       tile_buff2 = rot270(tile_buff)
       call check_match(tile1, tile_buff2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff
         return
       end if


       end subroutine check_all_matches

     function flip_ver(tile) result(tile2)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile
       character(len=1),             dimension(10,10) :: tile2


       tile2(:,:) = tile(:,10:1:-1)

     end function

     function flip_hor(tile) result(tile2)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile
       character(len=1),             dimension(10,10) :: tile2


       tile2(:,:) = tile(10:1:-1, :)

     end function

     function rot90(tile) result(tile2)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile
       character(len=1),             dimension(10,10) :: tile2

       integer :: i, j

       do i = 1, 10
         do j = 1, 10
           tile2(10+1-j, i) = tile(i, j)
         end do
       end do

     end function

     function rot180(tile) result(tile2)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile
       character(len=1),             dimension(10,10) :: tile2

       tile2 = rot90(rot90(tile))

     end function

     function rot270(tile) result(tile2)
       implicit none
       character(len=1), intent(in), dimension(10,10) :: tile
       character(len=1),             dimension(10,10) :: tile2

       tile2 = rot180(rot90(tile))

     end function

end program main
