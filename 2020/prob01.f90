program prob01
   integer, dimension(1000) :: expenses=0
   integer                  :: i, j, k, status, temp, nvals=0


   open (unit = 9, file = 'data/input1.txt', status = 'OLD', action = 'READ', &
           iostat = status)

   fileopen: if (status == 0) then
      do
         read(9, *, iostat = status) temp
         if (status /= 0) exit
         nvals = nvals + 1
         expenses(nvals) = temp
      end do
   else fileopen
      write(*,*) 'oops'
   end if fileopen


   outer: do i = 1, size(expenses)
      do j = i+1, size(expenses)
         if (expenses(i) + expenses(j) == 2020) then
             write(*,*) expenses(i)*expenses(j)
         end if
         do k = j+1, size(expenses)
            if (expenses(i)+expenses(j)+expenses(k) == 2020) then
               write(*,*) expenses(i)*expenses(j)*expenses(k)
               exit
            end if
         end do
      end do
   end do outer

end program prob01
