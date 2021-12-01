  ! Included file for test_hashtbl.f90
  PRINT*, ' '

  sum = 0
  PRINT*, 'Mild stress test.'
  DO i = 1,2000 ! 4byte integers default on most systems
     CALL RANDOM_NUMBER(rand)
     rand_int1 = NINT(rand*1000)
     rand_str1 = TRANSFER(rand_int1,rand_str1)
     CALL RANDOM_NUMBER(rand)
     rand_int2 = NINT(rand*1000)
     rand_str2 = TRANSFER(rand_int2,rand_str2)
     CALL table%put(key=rand_str1, val=rand_str2)
     CALL table%get(key=rand_str1,val=out)
     IF (TRANSFER(out,rand_int2) /= rand_int2) THEN
        PRINT*, 'Error, i=',i,' key=',rand_int1,' Val=',rand_int2,' &
             &Out=',TRANSFER(out,rand_int2)
        sum = sum + 1
     END IF     
  END DO
  PRINT*, 'Number of errors:',sum
