import numpy as np

Intcode = np.array([1,9,10,3,2,3,11,0,99,30,40,50])


Intcode = np.array([1,0,0,0,99])
Intcode = np.array([2,3,0,3,99])
Intcode = np.array([2,4,4,5,99,0])
Intcode = np.array([1,1,1,4,99,5,6,0,99])

Intcode = np.genfromtxt('input02.txt', delimiter=',', dtype=int)

def output(Intcode, noun, verb):
    Intcode[1] = noun
    Intcode[2] = verb
    for i in range(0, len(Intcode), 4):
        if Intcode[i] == 1:
            Intcode[Intcode[i+3]] = Intcode[Intcode[i+2]] + Intcode[Intcode[i+1]]
        elif Intcode[i] == 2:                                                  
            Intcode[Intcode[i+3]] = Intcode[Intcode[i+2]] * Intcode[Intcode[i+1]]
        elif Intcode[i] == 99:
            break
    return Intcode[0]


print(output(Intcode, 12, 2))



for noun in range(0, 100):
    for verb in range(0,100):
        Intcode = np.genfromtxt('input02.txt', delimiter=',', dtype=int)
        if output(Intcode, noun, verb) == 19690720:
            print(100*noun + verb)
            break

