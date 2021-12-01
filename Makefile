F90 = gfortran
F90FLAGS=-O3 -Wall -Wextra -std=f2008
SRC=dictionary_m.f90 lexsort.f90 hashtbl.f90 sorts.f90 $(wildcard prob??.f90)
SRC=dictionary_m.f90 lexsort.f90 hashtbl.f90 sorts.f90
OBJ=${SRC:.f90=.o}

TARGETS= prob01 prob02 prob03 prob04 prob05


%.o: %.f90
	$(F90) $(F90FLAGS) -o $@ -c $<


ans01: prob01.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans02: prob02.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans03: prob03.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans04: prob04.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans05: prob05.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans06: prob06.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans07: prob07.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans08: prob08.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans09: prob09.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans10: prob10.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans11: prob11.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans12: prob12.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans13: prob13.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans15: prob15.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans16: prob16.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans17: prob17.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans18: prob18.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans19: prob19.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans20: prob20.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans21: prob21.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans22: prob22.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans23: prob23.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans24: prob24.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)
ans25: prob25.o $(OBJ)
	$(F90) $(F90FLAGS) -o $@ $< $(OBJ)


all: ans01 ans02 ans03 ans04 ans05 ans06 ans07 ans08 ans09 ans10 ans11 ans12 ans13 ans15 ans16 ans17 ans18 ans19 ans20 ans21 ans22 ans23 ans24 ans25

.PHONY: clean
clean:
	rm -f *.mod *.o ans?? *.out
