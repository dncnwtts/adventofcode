import numpy as np
from intcode import Intcode_output as Intcode


code = np.genfromtxt('input05.txt', delimiter=',', dtype=int)

Intcode(code, 1)

print('\n')

code = np.genfromtxt('input05.txt', delimiter=',', dtype=int)
Intcode(code, 5)
