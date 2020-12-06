program main
   implicit none
   integer                   :: prod, i, j, k, status, ioerror, n=0, m=0
   character(len=26)         :: msg, alphabet
   integer, dimension(26)    :: forms
   character(len=10)         :: err_string


   alphabet = 'abcdefghijklmnopqrstuvwxyz'

   forms = 0

   open (unit=9, file='data/input6.txt', status='OLD', action='READ', &
           iostat=ioerror, iomsg=err_string)

   fileopen: if (status == 0) then
      do
         read(9, '(A)', iostat=status) msg
         if (status /= 0) exit
         if (len(trim(msg)) == 0) then
            !write(*,*) 'number of group members', m
            forms = forms/m
            !write(*,*) 'Done group', sum(forms)
            n = n + sum(forms)
            forms = 0
            m = 0
         else
            do i=1, len(trim(msg))
                !write(*,*) msg(i:i)
                j = index(alphabet, msg(i:i))
                forms(j) = forms(j) + 1
            end do
            m = m + 1
         end if
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen

   write(*,*) n

end program main
