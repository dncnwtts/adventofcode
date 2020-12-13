program main
   implicit none
   integer(kind=16)                    :: t0, n, m, i, j, k
   integer(kind=16)                    :: ans, c1, c2
   integer(kind=16)                    :: a1, a2, m1, m2, n1, n2, x
   integer                            :: nvals=0, status, ioerror
   real :: n_nonzero = 0, test
   integer(kind=16), allocatable, dimension(:) :: a, b
   character(len=200)         :: msg
   character(len=200)         :: err_string
   




   open (unit = 9, file = 'data/input13.txt', status = 'OLD', action = 'READ', &
           iostat = ioerror, iomsg = err_string)

   fileopen: if (ioerror == 0) then
     i = 1
     do
       read(9, '(A)', iostat = ioerror) msg
       if (ioerror /= 0) exit
       if (i == 1) then
         read(msg, *) t0
         m = t0
       else
         do
           j = index(msg, ',')
           if (j .ne. 0) then
             if (msg(:j-1) .ne. 'x') read(msg(:j-1),*) n
             msg = msg(j+1:)
           else
             if (msg .ne. 'x') read(msg,*) n
           end if
           if ( (t0/n+1)*n-t0 < m) then
             m = (t0/n+1)*n-t0
             ans = m*n
           end if
           nvals = nvals + 1
           if (j == 0) exit
         end do
       end if
       i = i + 1
     end do
     write(*,*) ans

     rewind (unit = 9)
     i = 1
     allocate (a(nvals))
     allocate (b(nvals))
     a = 0
     b = 0
     do
       read(9, '(A)', iostat = status) msg
       if (status /= 0) exit
       if (i == 2) then
         do k = 1, nvals
           j = index(msg, ',')
           if (j .ne. 0) then
             if (msg(:j-1) .ne. 'x') read(msg(:j-1),*) a(k)
             msg = msg(j+1:)
           else
             if (msg .ne. 'x') read(msg,*) a(k)
           end if
         end do
       end if
       i = i + 1
     end do
   
     c1 = 0
     c2 = 1
     a1 = 0
     a2 = 1
     n1 = a(1)
     x = a1
     do i = 1, nvals-1
       if (a(i+1) == 0) then
         a2 = a2 + 1
       else
         n2 = a(i+1)
         call extended_gcd(n1, n2, m1, m2)
         x = x*m2*n2 - a2*m1*n1
         x = mod(x, n1*n2)
         n1 = n2*n1
         a1 = x
         a2 = i+1
       end if
     end do


     do n = 1, 10000
       test = 0
       x = x + n1
       do i = 1, nvals
         if (a(i) .ne. 0) then
           if (mod(x+i-1, a(i)) == 0) test = test+1
         else
           test = test + 1
         end if
       end do
       if (test == nvals) then
         write(*,*) x
         exit
       end if
     end do



   else fileopen
     write(*,*) 'oops'
   end if fileopen


   contains

     subroutine extended_gcd(a, b, old_s, old_t)
       ! From Extended Euclidean Algorithm on Wikipedia

       ! function extended_gcd(a, b)
       !    (old_r, r) := (a, b)
       !    (old_s, s) := (1, 0)
       !    (old_t, t) := (0, 1)
       !    
       !    while r ≠ 0 do
       !        quotient := old_r div r
       !        (old_r, r) := (r, old_r − quotient × r)
       !        (old_s, s) := (s, old_s − quotient × s)
       !        (old_t, t) := (t, old_t − quotient × t)
       !    
       !    output "Bézout coefficients:", (old_s, old_t)
       !    output "greatest common divisor:", old_r
       !    output "quotients by the gcd:", (t, s)
       implicit none
       integer(kind=16), intent(inout) :: a, b
       integer(kind=16) :: old_r, r, s, t, quotient, prov
       integer(kind=16), intent(out) :: old_s, old_t

       old_r = a
       r = b
       old_s = 1
       s = 0
       old_t = 0
       t = 1

       do
         if (r == 0) exit
         quotient = old_r / r
         prov = r
         r = old_r - quotient*prov
         old_r = prov

         prov = s
         s = old_s - quotient*prov
         old_s = prov

         prov = t
         t = old_t - quotient*prov
         old_t = prov

       end do




       end subroutine extended_gcd

end program main
