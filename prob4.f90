program main
   implicit none
   integer, dimension(1000)  :: expenses=0
   integer                   :: prod, i, j, k, status, ioerror
   character(len=200)         :: msg, err_string
   character(len=5)          :: ind_1, ind_2


   integer                   :: n_valid=0
   integer                   :: byr=0, iyr=0, eyr=0, hgt=0, hcl=0, ecl=0, pid=0, cid=0
   character(len=1)          :: c
   character(:), allocatable :: password



   open (unit=9, file='data/input4.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)

   j = 0
   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (status /= 0) exit
         write(*,*) msg
         if  (len(trim(msg)) == 0) then
             !write(*,*) byr, iyr, eyr, hgt, hcl, ecl, pid, cid
             if (cid == 0) then
                 if (byr+iyr+eyr+hgt+hcl+ecl+pid == 7) then
                     n_valid = n_valid + 1
                 end if
                 write(*,*) 'valid'
             else if (byr+iyr+eyr+hgt+hcl+ecl+pid+cid == 8) then
                 n_valid = n_valid + 1
                 write(*,*) 'valid'
             else
                 write(*,*) 'invalid'
             end if
             !write(*,*) 'New passport'
             byr=0
             iyr=0
             eyr=0
             hgt=0
             hcl=0
             ecl=0
             pid=0
             cid=0
             j=0
         end if
         do
            k = index(msg, ':')
            if (k == 0 ) exit
            !write(*,*) msg(k-3:k-1)
            select case (msg(k-3:k-1))
               case ('byr')
                   byr=1
               case ('iyr')
                   iyr=1
               case ('eyr')
                   eyr=1
               case ('hgt')
                   hgt=1
               case ('hcl')
                   hcl=1
               case ('ecl')
                   ecl=1
               case ('pid')
                   pid=1
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
