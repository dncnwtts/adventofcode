import numpy as np
import matplotlib.pyplot as plt


def check_adj(i, j, arr, n, dists, prevs):
    left = arr[i,j-1] - arr[i, j]
    rght = arr[i,j+1] - arr[i, j]
    up   = arr[i+1,j] - arr[i, j]
    down = arr[i-1,j] - arr[i, j]

    left = left >= -1
    rght = rght >= -1
    up   = up >= -1
    down = down >= -1

    n_new = dists[(i,j)] + 1
    if left and (n_new < dists[(i,j-1)]):
        dists[(i,j-1)] = n_new
        prevs[(i,j-1)] = (i,j)
    if rght and (n_new < dists[(i,j+1)]):
        dists[(i,j+1)] = n_new
        prevs[(i,j+1)] = (i,j)
    if up and (n_new < dists[(i+1,j)]):
        dists[(i+1,j)] = n_new
        prevs[(i+1,j)] = (i,j)
    if down and (n_new < dists[(i-1,j)]):
        dists[(i-1,j)] = n_new
        prevs[(i-1,j)] = (i,j)

    return


f = open('input12.txt')
lines = f.readlines()
bla = np.zeros((len(lines), len(lines[0])-1))
for i,line in enumerate(lines):
    for j in range(len(line.strip())):
        bla[i,j] = ord(line[j])


bla = np.pad(bla, 1, mode='constant', constant_values=-np.inf)



dists = {}
prevs = {}
for i in range(len(bla)):
    for j in range(len(bla[0])):
        dists[(i,j)] = np.inf



i_f, j_f = np.where(bla == ord('S'))
bla[i_f, j_f] = ord('a')

i,j = np.where(bla == ord('E'))
bla[i,j] = ord('z')

dists[(i[0],j[0])] = 0


n = 0
while True:
    for key in dists.keys():
        if dists[key] < np.inf:
            check_adj(*key, bla, n, dists, prevs)
    if dists[(i_f[0], j_f[0])] < np.inf:
        break
    n += 1

print(dists[(i_f[0], j_f[0])])
d_bla = np.zeros_like(bla)
for key in dists.keys():
    d_bla[key] = dists[key]
plt.figure()
plt.imshow(d_bla)



i_f, j_f = np.where(bla == ord('a'))
min_dists = []
for i, j in zip(i_f, j_f):
    min_dists.append(dists[(i,j)])
print(min(min_dists))
plt.show()
