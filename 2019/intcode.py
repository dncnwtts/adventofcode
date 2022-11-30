import numpy as np
import time

def Intcode_output(Intcode, input, parameter_mode=0):
    i = 0
    while Intcode[i] != 99:
        opcode = Intcode[i] % 100
        C  = (Intcode[i] // 100) % 10
        B  = (Intcode[i] // 1000) % 10
        A  = (Intcode[i] // 10000) % 10
        i += 1
        if opcode < 3:
            if C == 0:
                val1 = Intcode[Intcode[i]]
            elif C == 1:
                val1 = Intcode[i]
            if B == 0:
                val2 = Intcode[Intcode[i+1]]
            elif B == 1:
                val2 = Intcode[i+1]
            if A == 0:
                val3 = Intcode[Intcode[i+2]]
            elif A == 1:
                val3 = Intcode[i+2]
            i += 3
        if opcode == 1:
            if A == 0:
                Intcode[Intcode[i]] = val1 + val2
            elif A == 1:
                Intcode[i] = val1 + val2
            i += 1
        elif opcode == 2:
            if A == 0:
                Intcode[Intcode[i]] = val1 * val2
            elif A == 1:
                Intcode[i] = val1 * val2
            i += 1
        elif opcode == 3:
            Intcode[Intcode[i]] = input
            i += 1
        elif opcode == 4:
            output = Intcode[Intcode[i]]
            print(output)
            i += 1
        elif opcode == 5:
            if Intcode[i] != 0:
               i = Intcode[Intcode[i+1]]
        elif opcode == 6:
            if Intcode[i] == 0:
                i = Intcode[Intcode[i+1]]
        elif opcode == 7:
            if Intcode[Intcode[i]] < Intcode[Intcode[i+1]]:
                Intcode[Intcode[i+2]] = 1
            else:
                Intcode[Intcode[i+2]] = 0
            i += 1
        elif opcode == 8:
            if Intcode[Intcode[i]] == Intcode[Intcode[i+1]]:
                Intcode[Intcode[i+2]] = 1
            else:
                Intcode[Intcode[i+2]] = 0
            i += 1
    return Intcode


thing1 = [3,9,8,9,10,9,4,9,99,-1,8]
Intcode_output(thing1, 8)
thing2 = [3,9,7,9,10,9,4,9,99,-1,8]
Intcode_output(thing2, 7)
thing3 = [3,3,1108,-1,8,3,4,3,99]
Intcode_output(thing3, 8)
thing4 = [3,3,1107,-1,8,3,4,3,99]
Intcode_output(thing4, 7)
