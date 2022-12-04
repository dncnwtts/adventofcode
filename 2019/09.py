import numpy as np
from intcode import Intcode_output as Intcode

code0 = np.genfromtxt('input09.txt', delimiter=',').astype('int')
code = np.zeros(10*len(code0), dtype=int)
code[:len(code0)] = code0
code = list(code)

ind = 0
relbase = 0
while code[ind] != 99:
    output, code, ind, relbase = Intcode(code, 1, i=ind, relbase=relbase)
print(output)

ind = 0
relbase = 0
while code[ind] != 99:
    output, code, ind, relbase = Intcode(code, 2, i=ind, relbase=relbase)
print(output)
