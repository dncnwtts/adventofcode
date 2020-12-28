program main
   implicit none
   integer, parameter        :: charlen=80, lim=70
   integer                   :: i, j, k, i1, j1, l, m, status, ioerror
   integer                   :: nvals=0, ntiles=0
   integer(kind=16)          :: prod
   character(len=charlen)    :: msg
   character(len=charlen)    :: err_string, line
   character(len=80), allocatable, dimension(:) :: a, b
   character(len=1), allocatable, dimension(:,:,:) :: tiles, tiles_buff
   character(len=1), allocatable, dimension(:,:) :: monster
   logical                   :: suc
   integer, allocatable, dimension(:) :: tile_IDs, tile_IDs_buff, num_matches
   character(len=1), allocatable, dimension(:,:) :: picture, picture_buff

   open (unit = 9, file = 'data/input20.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)
   open (unit = 8, file = 'data/input20_image.txt', status = 'OLD', action = 'READ', &
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
      allocate( tile_IDs_buff(ntiles) )
      allocate( num_matches(ntiles) )
      allocate( tiles(ntiles, 10, 10) )
      allocate( tiles_buff(ntiles, 10, 10) )
      allocate( picture(int(ntiles**0.5)*10, int(ntiles**0.5)*10) )
      allocate( picture_buff(int(ntiles**0.5)*10, int(ntiles**0.5)*10) )
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
             tiles(ntiles, j, k) = line(k:k)
           end do
         end if
      end do

      tile_IDs_buff = tile_IDs



      tiles_buff = tiles

      ! Need to just choose the right orientation
      tiles(1,:,:) =        tiles(1,:,:)
      ! tiles(1,:,:) =  rot90(tiles(1,:,:))
      ! tiles(1,:,:) = rot180(tiles(1,:,:))
      ! tiles(1,:,:) = rot270(tiles(1,:,:))
      ! tiles(1,:,:) = flip_ver(       tiles(1,:,:))
      ! tiles(1,:,:) = flip_ver( rot90(tiles(1,:,:)))
      ! tiles(1,:,:) = flip_ver(rot180(tiles(1,:,:)))
      ! tiles(1,:,:) = flip_ver(rot270(tiles(1,:,:)))

      do k = 1, ntiles
        do l = 1, ntiles
          if (k == l) cycle
          i = 0
          j = 0
          call check_all_matches(tiles(k,:,:), tiles(l,:,:), i, j)
          if (i .ne. 0 .or. j .ne. 0) then
            num_matches(k) = num_matches(k) + 1
          end if
        end do
      end do

      prod = 1
      do k = 1, ntiles
        ! assign one of these k's to the top-left corner.
        if (num_matches(k) == 2) then
          if (prod == 1) then
            tiles_buff(1,:,:) = tiles(k,:,:)
            tiles_buff(k,:,:) = tiles(1,:,:)
            tiles = tiles_buff
          end if
          prod = prod*tile_IDs(k)
        end if
      end do
      write(*,*) prod


      suc = .false.
      call tilecheck(tiles, suc)
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        tiles(1,:,:) = flip_ver(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if
      if (.not. suc) then
        tiles(1,:,:) = rot90(tiles(1,:,:))
        call tilecheck(tiles, suc)
      end if


      picture = ''

      do i = 1, ntiles
        j = (i-1)/int(ntiles**0.5)+1
        k = mod(i-1, int(ntiles**0.5)) + 1
        picture((j-1)*10+1:j*10, (k-1)*10+1:k*10) = tiles(i,:,:)
      end do

      picture = ' '

      do i = 1, ntiles
        j = (i-1)/int(ntiles**0.5)+1
        k = mod(i-1, int(ntiles**0.5)) + 1
        picture((j-1)*10+2:j*10-1, (k-1)*10+2:k*10-1) = tiles(i, 2:9, 2:9)
      end do

      l = 0
      do i = 1, int(ntiles**0.5)*10
        l = l + 1
        k = 0
        do j = 1, int(ntiles**0.5)*10
          if (picture(i,j) == ' ') cycle
          k = k + 1
          picture_buff(l, k) = picture(i, j)
        end do
        if (k == 0)  l = l - 1
      end do

      nvals = 0
      do
         read(8, '(A)', iostat = status) msg
         if (status /= 0) exit
         nvals = nvals + 1
      end do
      allocate( b(nvals), stat = status)
      if (status == 0) then
          rewind( unit = 8)
      else
          write(*,*) status
      end if

      allocate( monster(nvals, 20) )

      do i = 1, nvals
         read(8, '(A)', iostat = status) b(i)
      end do

      do i = 1, nvals
        do j = 1, len(trim(b(i)))
          line = b(i)
          monster(i, j) = line(j:j)
        end do
      end do

      picture = picture_buff

      call flipfind(monster, picture)

      
      ! do i = 1, int(ntiles**0.5)*10
      !  if (len(adjustr(picture(i,:))) == 0) cycle
      !  write(*,*) adjustr(picture(i,:))
      ! end do

      write(*,*) count_rough(picture)

      deallocate( a, tile_IDs, tiles, tiles_buff, picture, picture_buff)

   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains

     function count_rough(picture) result(num)
       implicit none
       character(len=1), intent(in), dimension(:,:) :: picture
       integer :: num, i, j
       integer, dimension(2) :: s
       s = shape(picture)

       num = 0
       do  i = 1, s(1)
         do j = 1, s(2)
           if (picture(i,j) == '#') num = num + 1
         end do
       end do

       end function

     subroutine flipfind(monster, picture)
       implicit none
       character(len=1), intent(in),    dimension(:,:) :: monster
       character(len=1), intent(inout), dimension(:,:) :: picture

       integer :: orig, num

       orig = count_rough(picture)

       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if

       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if
       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if
       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if

       picture = rot90(picture)
       picture = flip_ver(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if

       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if
       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if
       picture = rot90(picture)
       call find_monster_in_picture(monster, picture)
       num = count_rough(picture)
       if (num < orig) then
         return
       end if


       end subroutine flipfind

     subroutine find_monster_in_picture(monster, picture)
       implicit none
       character(len=1), intent(in),    dimension(:,:) :: monster
       character(len=1), intent(inout), dimension(:,:) :: picture

       integer :: i, j, i1, j1, wrong
       integer, dimension(2) :: s1, s2

       s1 = shape(monster)
       s2 = shape(picture)

       big: do i1 = 1, s2(1)-s1(1)
         small: do j1 = 1, s2(2)-s1(2)
           wrong = 0
           do i = 1, s1(1)
             do j = 1, s1(2)
               if (monster(i,j) == '#') then
                 if (picture(i+i1-1, j+j1-1) .ne. '#') then
                   wrong = wrong + 1
                 end if
               end if
             end do
           end do

           if (wrong == 0) then
             do i = 1, s1(1)
               do j = 1, s1(2)
                 if (monster(i,j) == '#') then
                   picture(i+i1-1, j+j1-1) = 'O'
                 end if
               end do
             end do
           end if

         end do small
       end do big




       end subroutine find_monster_in_picture

     subroutine check_match(tile1, tile2, i, j)
       implicit none
       character(len=1), intent(in), dimension(:,:) :: tile1
       character(len=1), intent(in), dimension(:,:) :: tile2
       integer, intent(out) :: i, j
       integer, dimension(2) :: s

       s = shape(tile1)

       i = 0
       j = 0
       if (all(tile1(1, :) == tile2(s(1), :))) then
         i = 0
         j = -1
       else if (all(tile1(:, 1) == tile2(:, s(1)))) then
         i = -1
         j = 0
       else if (all(tile1(s(1),:) == tile2(1, :))) then
         i = 0
         j = 1
       else if (all(tile1(:, s(1)) == tile2(:, 1))) then
         i = 1
         j = 0
       end if

       end subroutine check_match

     subroutine check_all_matches(tile1, tile2, i, j)
       implicit none
       character(len=1), intent(in), dimension(:, :) :: tile1
       character(len=1), intent(inout), dimension(:,:) :: tile2
       character(len=1), allocatable, dimension(:,:) :: tile_buff, tile_buff2
       integer, intent(out) :: i, j
       integer, dimension(2) :: s

       s = shape(tile1)

       allocate(tile_buff(s(1), s(2)))
       allocate(tile_buff2(s(1), s(2)))

       i = 0
       j = 0

       call check_match(tile1, tile2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         return
       end if
       tile_buff = flip_ver(tile2)
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
         tile2 = tile_buff2
         return
       end if
       tile_buff2 = rot180(tile_buff)
       call check_match(tile1, tile_buff2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff2
         return
       end if
       tile_buff2 = rot270(tile_buff)
       call check_match(tile1, tile_buff2, i, j)
       if (i .ne. 0 .or. j .ne. 0) then
         tile2 = tile_buff2
         return
       end if


       end subroutine check_all_matches

     function flip_ver(tile) result(tile2)
       implicit none
       character(len=1), intent(in),  dimension(:,:) :: tile
       character(len=1), allocatable, dimension(:,:) :: tile2

       integer, dimension(2) :: s
       s = shape(tile)
       allocate(tile2(s(1), s(2)))

       tile2(:,:) = tile(:, s(1):1:-1)

     end function


     function rot90(tile) result(tile2)
       implicit none
       character(len=1), intent(in),  dimension(:,:) :: tile
       character(len=1), allocatable, dimension(:,:) :: tile2

       integer :: i, j
       integer, dimension(2) :: s

       s = shape(tile)
       allocate(tile2(s(1), s(2)))


       do i = 1, s(1)
         do j = 1, s(2)
           tile2(s(1)+1-j, i) = tile(i, j)
         end do
       end do

     end function

     function rot180(tile) result(tile2)
       implicit none
       character(len=1), intent(in),  dimension(:,:) :: tile
       character(len=1), allocatable, dimension(:,:) :: tile2
       integer, dimension(2) :: s

       s = shape(tile)
       allocate(tile2(s(1), s(2)))

       tile2 = rot90(rot90(tile))

     end function

     function rot270(tile) result(tile2)
       implicit none
       character(len=1), intent(in),  dimension(:,:) :: tile
       character(len=1), allocatable, dimension(:,:) :: tile2
       integer, dimension(2) :: s

       s = shape(tile)
       allocate(tile2(s(1), s(2)))

       tile2 = rot180(rot90(tile))

     end function


     subroutine tilecheck(tiles, suc)
       implicit none
       character(len=1), intent(inout), dimension(:,:,:) :: tiles
       logical, intent(inout) :: suc
       character(len=1), allocatable,   dimension(:,:,:) :: tiles_buff

       integer :: i, j, k, ntiles
       integer, dimension(3) :: s

       s = shape(tiles)
       allocate( tiles_buff(s(1), s(2), s(3)))

       tiles_buff = tiles

       ntiles = s(1)


       suc = .true.
       main: do k = 1, ntiles
         do l = k+1, ntiles
           i = 0
           j = 0
           call check_all_matches(tiles(k,:,:), tiles(l,:,:), i, j)
           if (i .ne. 0 .or. j .ne. 0) then
             i1 = mod(k-1, int(ntiles**0.5)) + 1
             j1 = (k-1)/int(ntiles**0.5) + 1
             m = i1+i + (j1+j-1)*int(ntiles**0.5)
             if (m < 1) then
               suc = .false.
               exit main
             end if
             tiles_buff(m,:,:) = tiles(l,:,:)
             tiles_buff(l,:,:) = tiles(m,:,:)
             tiles = tiles_buff
           end if
         end do
       end do main
     end subroutine tilecheck

end program main
