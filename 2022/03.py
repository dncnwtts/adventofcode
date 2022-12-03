import numpy as np

d = np.loadtxt('input03.txt', dtype=str)
s = 0
for di in d:
    n = len(di)//2
    for i in range(n):
        if di[:n][i] in di[n:]:
            v = ord(di[:n][i])
            if v > ord('Z'):
                s += v - ord('a')+1
            else:
                s += v - ord('A')+27
            break
print(s)

s = 0
for i in range(0,len(d),3):
    d1 = d[i]
    d2 = d[i+1]
    d3 = d[i+2]
    for j in range(len(d1)):
        if (d1[j] in d2) and (d1[j] in d3):
            v = ord(d1[j])
            if v > ord('Z'):
                s += v - ord('a')+1
            else:
                s += v - ord('A')+27
            break
print(s)
