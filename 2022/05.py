import numpy as np
import re

stacks = {}
stacks[1] = ['N','D','M','Q','B','P','Z']
stacks[2] = ['C','L','Z','Q','M','D','H','V']
stacks[3] = ['Q','H','R','D','V','F','Z','G']
stacks[4] = ['H','G','D','F','N']
stacks[5] = ['N','F','Q']
stacks[6] = ['D','Q','V','Z','F','B','T']
stacks[7] = ['Q','M','T','Z','D','V','S','H'] 
stacks[8] = ['M','G','F','P','N','Q'] 
stacks[9] = ['B','W','R','M']

f = open('input05.txt')
Lines = f.readlines()
for line in Lines:
    num, origin, dest = [int(s) for s in re.findall(r'\d+', line)]
    for i in range(num):
        stacks[dest].append(stacks[origin].pop())

ans = ''
for i in range(1,10):
    ans += stacks[i][-1]
print(ans)

stacks = {}
stacks[1] = ['N','D','M','Q','B','P','Z']
stacks[2] = ['C','L','Z','Q','M','D','H','V']
stacks[3] = ['Q','H','R','D','V','F','Z','G']
stacks[4] = ['H','G','D','F','N']
stacks[5] = ['N','F','Q']
stacks[6] = ['D','Q','V','Z','F','B','T']
stacks[7] = ['Q','M','T','Z','D','V','S','H'] 
stacks[8] = ['M','G','F','P','N','Q'] 
stacks[9] = ['B','W','R','M']

f = open('input05.txt')
Lines = f.readlines()
for line in Lines:
    num, origin, dest = [int(s) for s in re.findall(r'\d+', line)]
    if num == 1:
        stacks[dest].append(stacks[origin].pop())
    else:
        #print(stacks[origin])
        stacks[dest] += stacks[origin][-num:]
        for i in range(num):
            stacks[origin].pop()

ans = ''
for i in range(1,10):
    ans += stacks[i][-1]
print(ans)
