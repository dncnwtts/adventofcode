# adventofcode

Following https://adventofcode.com/2020

Using fortran, compiling with
`gfortran prob*.f90`
and executing results with
`./a.out`


To compile, e.g., problem 7, execute
```
gfortran -c hashtbl.f90 
gfortran prob7.f90 hashtbl.f90  -g -Wall

```


Using `fortran-linter probx.f90 -i` (installed with `pip install fortran-linter`).

Note for future readers; I basically couldn't figure out problem 23. But the rest I swear I did by myself!
