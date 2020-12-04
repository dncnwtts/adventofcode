program main
   implicit none
   integer, dimension(1000)  :: expenses=0
   integer                   :: prod, i, j, k, status, ioerror, n
   character(len=200)         :: msg, err_string
   character(len=5)          :: ind_1, ind_2


   integer                   :: n_valid=0, n_invalid=0
   integer                   :: byr=0, iyr=0, eyr=0, hgt=0, hcl=0, ecl=0, pid=0, cid=0, s
   character(len=1)          :: c
   character(:), allocatable :: password



   open (unit=9, file='data/input4.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)

   j = 0
   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (len(trim(msg)) == 0) then
             s = byr+iyr+eyr+hgt+hcl+ecl+pid
             byr=0
             iyr=0
             eyr=0
             hgt=0
             hcl=0
             ecl=0
             pid=0
             if (cid == 0) then
                 if (s == 7) then
                     n_valid = n_valid + 1
                 else
                     n_invalid = n_invalid + 1
                 end if
             else if (s == 7) then
                 n_valid = n_valid + 1
             else if (s == 0) then
             else
                 n_invalid = n_invalid + 1
             end if
             cid=0
             j=0
         end if
         if (status /= 0) exit
         do
            k = index(msg, ':')
            if (k == 0 ) exit
            select case (msg(k-3:k-1))
               case ('byr')
                  read(msg(k+1:k+5),*) n
                  if (n .ge. 1920 .and. n .le. 2002) then
                     byr=1
                  end if
               case ('iyr')
                  read(msg(k+1:k+5),*) n
                  if (n .ge. 2010 .and. n .le. 2020) then
                     iyr=1
                  end if
               case ('eyr')
                  read(msg(k+1:k+5),*) n
                  if (n .ge. 2020 .and. n .le. 2030) then
                     eyr=1
                  end if
               case ('hgt')
                  j = index(msg(k+1:k+6), 'in')
                  if (j .ne. 0) then
                     read(msg(k+1:k+j-1),*) n
                     if (n .ge. 59 .and. n .le. 76) then
                        hgt=1
                     end if
                  end if
                  j = index(msg(k+1:k+6), 'cm')
                  if (j .ne. 0) then
                     read(msg(k+1:k+j-1),*) n
                     if (n .ge. 150 .and. n .le. 193) then
                        hgt=1
                     end if
                  end if
               case ('hcl')
                   if (msg(k+1:k+1) == '#') then
                       j = index(msg(k+1:k+7), ' ')
                       if (j == 0) then
                          hcl=1
                       end if
                   end if
               case ('ecl')
                  j = index('amb blu brn gry grn hzl oth ', msg(k+1:k+4))
                  if (j == 0) then
                     ecl=0
                  else
                     ecl=1
                  end if
               case ('pid')
                  n = index(msg(k+1:k+11), ' ')
                  if (n == 10) then
                     pid=1
                  end if
               case ('cid')
                  cid=1

            end select
            msg(:k+1) = ' '
         end do
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   write(*,*) n_valid

end program main
