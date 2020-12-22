program main
   implicit none
   integer(kind=16), parameter        :: charlen=250
   integer(kind=16)                   :: i, status, ioerror, nvals=0
   character(len=charlen)         :: msg
   character(len=10)         :: err_string
   character(len=charlen), allocatable, dimension(:) :: a
   character(len=charlen)                            :: line1
   integer(kind=16)            :: vals, val


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
      do i = 1, nvals
        line1 = a(i)
        val = eval(line1)
        vals = vals + val
      end do

      write(*,*) vals

      vals = 0
      do i = 1, nvals
        line1 = a(i)
        val = eval2(line1)
        vals = vals + val
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
       character(len=charlen)  :: line2
       integer(kind=16)            :: i, a, i1, j1
       integer(kind=16)  :: eval_result

       logical :: back=.true.


       line2 = line

       eval_result = 0

       do i = 1, len(trim(line))
         if (line(i:i) ==' ') then
           cycle
         else if (line(i:i) =='+') then
           cycle
         else if (line(i:i) =='*') then
           cycle  
         else if (line(i:i) =='(') then
           line2 = ' '
           line2(i+1:) = line(i+1:)
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
             cycle
           end if
         else if (line(i:i) ==')') then
           exit
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
             write(*,*) 'blank line...', line
           else 
             write(*,*) "Shouldn't be here2", line(i-2:i-2)
           end if
         end if

       end do

       line(:i) = ' '

       end function eval


     recursive function eval2(line) result(acc)
       ! Implementing https://github.com/mebeim/aoc/blob/master/2020/README.md#day-18---operation-order
       implicit none
       character(len=charlen), intent(inout)  :: line
       character(len=charlen)  :: line2
       character :: token
       integer(kind=16)            :: i, a 
       integer(kind=16)  :: mult, acc

       line2 = line

       mult = 1
       acc = 0

       do i = 1, len(trim(line))
         if (line(i:i) ==' ') then
           cycle
         else if (line(i:i) =='+') then
           token = '+'
         else if (line(i:i) =='*') then
           token = '*'
           mult = acc
           acc = 0
         else if (line(i:i) =='(') then
           line2 = ' '
           line2(i+1:) = line(i+1:)
           a = eval2(line2)

           line = line2
           acc = acc + a*mult
         else if (line(i:i) ==')') then
           exit
         else
           token = line(i:i)
           read(line(i:i), *) a
           acc = acc + a * mult
         end if

       end do

       line(:i) = ' '

       end function eval2



end program main
