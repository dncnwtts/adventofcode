import numpy as np

d = np.loadtxt('04.txt', dtype=str)
data = np.zeros((len(d), len(d)), dtype=str)
for i in range(len(d)):
    for j in range(len(d)):
        data[i,j] = d[i][j]


key = 'XMAS'
n = 0

# down right
for i in range(len(data)-3):
    for j in range(len(data)-3):
        s = ''
        diag = (np.arange(4)+i, np.arange(4)+j)
        for k in range(4):
            s += data[diag][k]
        if s == key:
            n += 1
        if s[::-1] == key:
            n += 1

# down left
for i in range(3, len(data)):
    for j in range(len(data)-3):
        s = ''
        diag = (i-np.arange(4), np.arange(4)+j)
        for k in range(4):
            s += data[diag][k]
        if s == key:
            n += 1
        if s[::-1] == key:
            n += 1

# right
for i in range(len(data)):
    for j in range(len(data)-3):
        s = ''
        right = (np.ones(4, dtype=int)*i, np.arange(4)+j)
        for k in range(4):
            s += data[right][k]
        if s == key:
            n += 1
        if s[::-1] == key:
            n += 1
# down
for i in range(len(data)-3):
    for j in range(len(data)):
        s = ''
        down = (np.arange(4)+i, np.ones(4, dtype=int)*j)
        for k in range(4):
            s += data[down][k]
        if s == key:
            n += 1
        if s[::-1] == key:
            n += 1

print(n)




n = 0

for i in range(1, len(data)-1):
    for j in range(1, len(data)-1):
        if data[i,j] == 'A':
            # check1
            c1 = (data[i+1,j+1] == 'M') & (data[i-1,j-1] == 'S')
            c2 = (data[i+1,j+1] == 'S') & (data[i-1,j-1] == 'M')

            c3 = (data[i+1,j-1] == 'M') & (data[i-1,j+1] == 'S')
            c4 = (data[i+1,j-1] == 'S') & (data[i-1,j+1] == 'M')
            if (c1 | c2) & (c3 | c4):
                n += 1
print(n)
