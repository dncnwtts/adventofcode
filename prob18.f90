program main
   implicit none
   integer(kind=16), parameter        :: charlen=250
   integer(kind=16)                   :: i, j, x, y, z, w, status, ioerror, nvals=0
   character(len=charlen)         :: msg
   character(len=10)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a
   character(len=80)                            :: line1
   integer(kind=16)            :: vals, val


   open (unit = 9, file = 'data/input18_dummy.txt', status = 'OLD', action = 'READ', &
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

      do i = 1, nvals
        write(*,*) trim(a(i))
        val = eval(a(i))
        write(*,*) val
        vals = vals + val
        !write(*,*) vals
        write(*,*)
      end do

      write(*,*) vals



      if (allocated(a)) deallocate(a)
   else fileopen
      write(*,*) 'File I/O Error'
   end if fileopen


   contains
     recursive function eval(line) result(eval_result)
       implicit none
       character(len=charlen), intent(inout)  :: line
       character(len=charlen)  :: line2, line_orig
       integer(kind=16)            :: i, j, a, b, i1, i2, j1, j2, lparen_ind=0, rparen_ind
       integer(kind=16)  :: eval_result, num_parens = 0
       integer(kind=16), allocatable, dimension(:) :: lparens, rparens

       logical :: back=.true.


       line2 = line
       line_orig = line

       eval_result = 0

       do i=1, len(trim(line))
         if (line(i:i)==' ') then
           cycle
         else if (line(i:i)=='(') then
           line2 = line(i+1:)
           a = eval(line2)

           i1 = index(line(:i), '+',  back)
           j1 = index(line(:i), '*',  back)
           line = line2
           
           if (eval_result == 0) then
             eval_result = a
           else if (i1 > j1) then
             eval_result = eval_result + a
           else if (j1 > i1) then
             eval_result = eval_result * a
           else
             !write(*,*) "Shouldn't be here1"
             cycle
           end if
         else if (line(i:i)==')') then
           exit
         else if (line(i:i)=='+') then
           cycle
         else if (line(i:i)=='*') then
           cycle  
         else

           i1 = index(line(:i), '+',  back)
           j1 = index(line(:i), '*',  back)


           read(line(i:i), *) a
           if (eval_result == 0) then
             eval_result = a
           else if (i1 > j1) then
             eval_result = eval_result + a
           else if (j1 > i1) then
             eval_result = eval_result * a
           else if (line(i-2:i-2) == ' ') then
             !write(*,*) 'blank line...', line
           else 
             !write(*,*) "Shouldn't be here2", line(i-2:i-2)
           end if
         end if

       end do

       !write(*,*) trim(line_orig)
       !write(*,*) 'Finished parentheses loop'
       !write(*,*) trim(line(:i)), eval_result

       line(:i) = ' '

       !write(*,*)



       end function eval

end program main
