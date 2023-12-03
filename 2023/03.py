import numpy as np
from itertools import product

def check_adj_symbs(arr, ij):
    i, j = ij
    vals_i = [i-1, i, i+1]
    vals_j = [j-1, j, j+1]
    num_inds = []
    for ind in product(vals_i, vals_j):
        if arr[ind].isdigit():
            num_inds.append(ind)
    return num_inds

def check_adj_digits(arr, ij):
    i0, j0 = ij
    if arr[i0,j0] == '.':
        return 0
    j = j0
    current = arr[i0, j]
    digit = ''
    while current.isdigit():
        digit = arr[i0,j] + digit
        arr[i0, j] = '.'
        j = j - 1
        current = arr[i0,j]
    j = j0 + 1
    current = arr[i0, j]
    while current.isdigit():
        digit = digit + arr[i0, j]
        arr[i0, j] = '.'
        j = j + 1
        current = arr[i0,j]
    return digit


with open('03.txt') as f:
    Lines = f.readlines()
    N = len(Lines)
    arr = []
    for i in range(len(Lines)):
        arr.append([])
        l = Lines[i].strip()
        for j in range(len(l)):
            arr[i] += [l[j]]

arr = np.pad(np.array(arr), 1, mode='constant', constant_values='.')

symb_inds = []
for i in range(len(arr)):
    for j in range(len(arr)):
        if (arr[i][j] != '.') & (not arr[i][j].isdigit()):
            symb_inds.append((i,j))

tot1 = 0
tot2 = 0
num_inds = check_adj_symbs(arr, symb_inds[0])
for si in symb_inds:
    num_inds = check_adj_symbs(arr, si)
    count = 0
    s1 = 1
    for ind in num_inds:
        v = int(check_adj_digits(arr, ind))
        tot1 += v
        if v != 0:
            s1 *= v
            count += 1
    if count == 2:
        tot2 += s1

print(tot1)
print(tot2)
