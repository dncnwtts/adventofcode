program main
   implicit none
   integer, parameter        :: charlen=200
   integer                   :: i, j, x, y, z, w, status, ioerror, nvals=0
   character(len=charlen)         :: msg
   character(len=10)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a
   character(len=80)                            :: line1
   integer            :: vals


   open (unit = 9, file = 'data/input18.txt', status = 'OLD', action = 'READ', &
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
      end do


      vals = 0

      do i = 1, 6
        vals = vals + eval(a(i))
        !write(*,*) vals
      end do



      if (allocated(a)) deallocate(a)
   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains
     recursive function eval(line) result(eval_result)
       implicit none
       character(len=charlen), intent(inout)  :: line
       character(len=charlen)  :: line2
       integer            :: i, j, a, b, i1, i2, j1, j2, lparen_ind=0, rparen_ind
       integer  :: eval_result, num_parens = 0
       integer, allocatable, dimension(:) :: lparens, rparens


       line2 = line
       do
         i1 = index(line2, '(')
         write(*,*) i1
         if (i1 == 0) exit
         num_parens = num_parens + 1
         line2(:i1+1) = ' '
         write(*,*) trim(line2)
       end do
       write(*,*) 'num_parens: ', num_parens

       if (num_parens > 0) then
         allocate(lparens(num_parens))
         allocate(rparens(num_parens))
         line2 = line
         do i = 1, num_parens
           lparens(i) = index(line2, '(')
           line2(:i+1) = ' '
         end do
         line2 = line
         do i = 1, num_parens
           rparens(i) = index(line2, ')')
           line2(:i+1) = ' '
         end do

         write(*,*) lparens
         write(*,*) rparens
       end if

       eval_result = 0

       !write(*,*) 'input line: ', trim(line)

       rparen_ind = index(line, ')')
       lparen_ind = 0

       do i=1, len(trim(line))
         !write(*,*) line(i:i), lparen_ind, rparen_ind, i
         if (i < lparen_ind .and. lparen_ind > 0) then
           cycle
         else if (line(i:i)==' ') then
           cycle
         else if (line(i:i)=='(') then
           line2 = line(i+1:rparen_ind-1)
           a = eval(line2)
           !rparen_ind = index(line(rparen_ind+1:), ')') + rparen_ind  + 1
           !lparen_ind = index(line(lparen_ind+1:), '(') + lparen_ind  + 1

           line(:rparen_ind) = ' '

           
           if (eval_result == 0) then
             eval_result = a
           else if (line(i-2:i-2) == '+') then
             eval_result = eval_result + a
           else if (line(i-2:i-2) == '*') then
             eval_result = eval_result * a
           else if (line(i-2:i-2) == ' ') then
             exit
           else
             write(*,*) "Shouldn't be here1", line(i-3:i-3)
           end if
         else if (line(i:i)==')') then
           !line(i+1:) = line(i+1:)
           !write(*,*) 'ending paren'
           exit
         else if (line(i:i)=='+') then
           cycle
         else if (line(i:i)=='*') then
           cycle  
         else
           read(line(i:i), *) a
           if (eval_result == 0) then
             eval_result = a
           else if (line(i-2:i-2) == '+') then
             eval_result = eval_result + a
           else if (line(i-2:i-2) == '*') then
             eval_result = eval_result * a
           else if (line(i-2:i-2) == ' ') then
             write(*,*) 'blank line...', line
             !exit
           else 
             write(*,*) "Shouldn't be here2", line(i-2:i-2)
           end if
         end if

         !write(*,*) i, line(i:i), ' ', trim(line), len(trim(line))

       end do

       write(*,*) trim(line), ' = ',eval_result


       end function eval

end program main
