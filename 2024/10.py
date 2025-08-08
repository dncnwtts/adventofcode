import numpy as np

def check_neighbors(d, i0, j0):
    neighbors = np.zeros(4, dtype=bool)
    if i0 > 0:
        up = i0-1, j0
        diff = d[up] - d[i0,j0] 
        if diff == 1:
            neighbors[0] = True
    if i0 < len(d)-1:
        down   = i0+1, j0
        diff = d[down] - d[i0,j0] 
        if diff == 1:
            neighbors[1] = True
    if j0 > 0:
        left = i0, j0-1
        diff = d[left] - d[i0,j0] 
        if diff == 1:
            neighbors[2] = True
    if j0 < len(d)-1:
        right=  i0, j0+1
        diff = d[right] - d[i0,j0] 
        if diff == 1:
            neighbors[3] = True
    return neighbors

def traverse(d, direction):
    if d[direction] == 9:
        return True
    i_new, j_new = direction
    next_dir = check_neighbors(d, i_new, j_new)

with open('10.txt') as f:
    data = f.readlines()

for i in range(len(data)):
    data[i] = data[i].strip()

def traverse(d, i0, j0):
    global n
    global m
    global peaks
    if d[i0,j0] == 9:
        if (i0,j0) in peaks.keys():
            m += 1
            return
        else:
            peaks[(i0,j0)] = True
            n += 1
            return 
    up = i0-1, j0
    down   = i0+1, j0
    left = i0, j0-1
    right=  i0, j0+1
    dir_s = [up, down, left, right]
    labs = ['up', 'down', 'left', 'right']
    next_dirs = check_neighbors(d, i0, j0)
    check = False
    for i in range(len(next_dirs)):
        if next_dirs[i]:
            traverse(d, *dir_s[i])
            check = True
    if not check:
        return
    return
d = np.zeros((len(data), len(data)), dtype=int)

for i in range(len(data)):
    for j in range(len(data)):
        d[i,j] = data[i][j]

trailheads = np.where(d == 0)
i0s, j0s = trailheads

n = 0
m = 0
for i0, j0 in zip(i0s, j0s):
    peaks = {}
    num_peaks = {}
    traverse(d, i0, j0)
print(n)
print(m+n)
