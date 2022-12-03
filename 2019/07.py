import numpy as np
from intcode import Intcode_output as Intcode
import itertools


code = np.genfromtxt('input07.txt', delimiter=',').astype('int')

max_out = 0
for sequence in itertools.permutations([0,1,2,3,4]):
    out = 0
    for s in sequence:
        out,code,pos = Intcode(code, out, phase=s)
    if out > max_out:
        max_out = out
print(max_out)



maxval = 0
for sequence in itertools.permutations([5,6,7,8,9]):
    codes = [np.genfromtxt('input07.txt', delimiter=',').astype('int') for i in range(5)]
    ints = [0,0,0,0,0]
    phases = [0,0,0,0,0]
    out = 0
    for i in range(len(sequence)):
        phases[i] = sequence[i]
    
    while codes[-1][ints[-1]] != 99:
        for i,s in enumerate(sequence):
            out_tmp,codes[i],ints[i]  = Intcode(codes[i], out, phase=phases[i], i=ints[i])
            if phases[i] is not None:
                phases[i] = None
            if type(out_tmp) == np.int64:
                out = out_tmp
    if out > maxval:
        maxval = out
print(maxval)
#print(18216)
