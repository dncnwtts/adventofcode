program main
   integer, dimension(1000)  :: expenses=0
   integer                   :: prod, i, j, k, status, ierror
   character(len=40)         :: msg, err_string
   character(len=5)          :: ind_1, ind_2


   integer                   :: min_num, max_num, num, p, n_valid=0, n_valid2=0, valid
   character(len=1)          :: c
   character(:), allocatable :: password



   open (unit=9, file='data/input2.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)


   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (status /= 0) exit
         i = index(msg, '-')
         j = index(msg, ':')
         read(msg(1:i-1),   *) min_num
         read(msg(i+1:j-2), *) max_num
         read(msg(j-2:j-1), *) c
         password = trim(msg(j+1:))
         p = 2
         num = 0
         if (password(min_num+1:min_num+1) == c .neqv. password(max_num+1:max_num+1) == c) then
             valid = valid + 1
         end if

         do
            if (index(password(p:), c) > 0) then
               p = p + index(password(p:), c)
               num = num +1
            else
               exit
            end if
         end do
         if (num .ge. min_num .and. num .le. max_num) then
             n_valid = n_valid + 1
         end if
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   write(*,*) n_valid

   write(*,*) valid

end program main
