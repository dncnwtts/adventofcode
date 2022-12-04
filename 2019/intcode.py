import numpy as np
import time

def Intcode_output(Intcode, inp, phase=None, i=0, relbase=0):
    while Intcode[i] != 99:
        opcode = Intcode[i] % 100
        C  = (Intcode[i] // 100) % 10
        B  = (Intcode[i] // 1000) % 10
        A  = (Intcode[i] // 10000) % 10
        i += 1
        assert opcode < 10, 'Your opcode does not make sense'
        if ((opcode < 3) or (opcode > 6)) and opcode < 9:
            if C == 0:
                val1 = Intcode[Intcode[i]]
            elif C == 1:
                val1 = Intcode[i]
            elif C == 2:
                val1 = Intcode[relbase + Intcode[i]]
            i += 1
            if B == 0:
                val2 = Intcode[Intcode[i]]
            elif B == 1:
                val2 = Intcode[i]
            elif B == 2:
                val2 = Intcode[relbase + Intcode[i]]
            i += 1
            if A == 0:
                val3 = Intcode[i]
            elif A == 1:
                val3 = i
            elif A == 2:
                val3 = relbase + Intcode[i]
            i += 1
        if opcode == 1:
            Intcode[val3] = val1 + val2
        elif opcode == 2:
            Intcode[val3] = val1 * val2
        elif opcode == 3:
            if phase is not None:
                inp = phase
                phase = None
            else:
                inp = inp
            if C == 0:
                Intcode[Intcode[i]] = inp
            elif C == 1:
                Intcode[i] = inp
            elif C == 2:
                Intcode[Intcode[i] + relbase] = inp
            i += 1
        elif opcode == 4:
            if C == 0:
                output = Intcode[Intcode[i]]
            elif C == 1:
                print('issue?')
                output = Intcode[i]
            elif C == 2:
                output = Intcode[relbase + Intcode[i]]
            return output, Intcode, i+1, relbase
        elif opcode == 5:
            if C == 0:
               if Intcode[Intcode[i]] != 0:
                  if B == 0:
                      i = Intcode[Intcode[i+1]]
                  elif B == 1:
                      i = Intcode[i+1]
                  elif B == 2:
                      i = Intcode[relbase + Intcode[i+1]]
               else:
                  i += 2
            elif C == 1:
               if Intcode[i] != 0:
                  if B == 0:
                      i = Intcode[Intcode[i+1]]
                  elif B == 1:
                      i = Intcode[i+1]
                  elif B == 2:
                      i = Intcode[relbase + Intcode[i+1]]
               else:
                  i += 2
            elif C == 2:
               if Intcode[relbase+Intcode[i]] != 0:
                  if B == 0:
                      i = Intcode[Intcode[i+1]]
                  elif B == 1:
                      i = Intcode[i+1]
                  elif B == 0:
                      i = Intcode[relbase + Intcode[i+1]]
               else:
                  i += 2
        elif opcode == 6:
            if C == 0:
                if Intcode[Intcode[i]] == 0:
                    if B == 0:
                        i = Intcode[Intcode[i+1]]
                    elif B == 1:
                        i = Intcode[i+1]
                    elif B == 2:
                        i = Intcode[relbase + Intcode[i+1]]
                else:
                    i += 2
            elif C == 1:
               if Intcode[i] == 0:
                  if B == 0:
                      i = Intcode[Intcode[i+1]]
                  elif B == 1:
                      i = Intcode[i+1]
                  elif B == 2:
                      i = Intcode[relbase + Intcode[i+1]]
               else:
                  i += 2
            elif C == 2:
                if Intcode[relbase+Intcode[i]] == 0:
                    if B == 0:
                        i = Intcode[Intcode[i+1]]
                    elif B == 1:
                        i = Intcode[i+1]
                    elif B == 2:
                        i = Intcode[relbase + Intcode[i+1]]
                else:
                    i += 2
        elif opcode == 7:
            if val1 < val2:
                Intcode[val3] = 1
            else:
                Intcode[val3] = 0
        elif opcode == 8:
            if val1 == val2:
                Intcode[val3] = 1
            else:
                Intcode[val3] = 0
        elif opcode == 9:
            if C == 0:
                relbase += Intcode[Intcode[i]]
            elif C == 1:
                relbase += Intcode[i]
            elif C == 2:
                relbase += Intcode[relbase + Intcode[i]]
            i += 1

    return Intcode, Intcode, i, relbase


if __name__ == '__main__':
    #thing1 = [3,9,8,9,10,9,4,9,99,-1,8]
    #print('should be 1')
    #Intcode_output(thing1, 8)
    #thing2 = [3,9,7,9,10,9,4,9,99,-1,8]
    #print('Should be 1')
    #Intcode_output(thing2, 7)
    #thing3 = [3,3,1108,-1,8,3,4,3,99]
    #print('should be 1')
    #Intcode_output(thing3, 8)
    #thing4 = [3,3,1107,-1,8,3,4,3,99]
    #print('should be 1')
    #Intcode_output(thing4, 7)
    #thing5 = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    #print('Should be 0')
    #thing5 = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    #Intcode_output(thing5, 0)
    #print('should be 1')
    #Intcode_output(thing5, 3)
    #thing6 = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    #print('Should be 0')
    #Intcode_output(thing6, 0)
    #print('Should be 1')
    #thing6 = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    #Intcode_output(thing6, 3)

    n = 7
    thing = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
            1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
            999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99 ]
    #Intcode_output(thing, [7])
    #Intcode_output(thing, [8])
    #Intcode_output(thing, [9])

    code0 = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
    code = np.zeros(300, dtype=int)
    code[:len(code0)] = code0
    code = list(code)
    ind = 0
    relbase = 0
    while code[ind] != 99:
        output, code, ind, relbase = Intcode_output(code, [], i=ind, relbase=relbase)
    print(output)
    assert output[:len(code0)] == code0, 'nope'

    code = [1102,34915192,34915192,7,4,7,99,0]
    output, code, ind, relbase = Intcode_output(code, [])
    ind = 0
    relbase = 0
    while code[ind] != 99:
        output, code, ind, relbase = Intcode_output(code, [], i=ind, relbase=relbase)
    print(output)

    code = [104,1125899906842624,99]
    ind = 0
    relbase = 0
    while code[ind] != 99:
        output, code, ind, relbase = Intcode_output(code, [], i=ind, relbase=relbase)
    print(output)
