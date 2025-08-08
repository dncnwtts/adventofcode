import numpy as np

with open('08.txt') as f:
    d = f.readlines()

for i in range(len(d)):
    d[i] = d[i].strip()

N = len(d)
d_ij = np.zeros((N, N), dtype=str)
for i in range(len(d)):
    for j in range(len(d)):
        d_ij[i][j] = d[i][j]

antinodes = np.zeros_like(d_ij)
antinodes[:,:] = '.'

symbs = np.unique(d_ij)
for s in symbs:
    if s == '.':
        continue
    x = np.where(d_ij == s)
    locs_i, locs_j = x
    for i in range(len(locs_i)):
        i0, j0 = locs_i[i], locs_j[i]
        delta_i, delta_j = locs_i - i0, locs_j - j0
        i_delts, j_delts = i0 + 2*delta_i, j0 + 2*delta_j
        inds = (i_delts >= 0) & (i_delts < N) & (j_delts >= 0) & (j_delts < N) & (delta_i != 0) & (delta_j != 0)
        i_delts = i_delts[inds]
        j_delts = j_delts[inds]
        antinodes[i_delts, j_delts] = '#'

print(d_ij)
print(antinodes)
print((antinodes=='#').sum())

antinodes = np.zeros_like(d_ij)
antinodes[:,:] = '.'

symbs = np.unique(d_ij)
for s in symbs:
    if s == '.':
        continue
    x = np.where(d_ij == s)
    locs_i, locs_j = x
    for i in range(len(locs_i)):
        i0, j0 = locs_i[i], locs_j[i]
        for n in range(50):
            delta_i, delta_j = locs_i - i0, locs_j - j0
            i_delts, j_delts = i0 + n*delta_i, j0 + n*delta_j
            inds = (i_delts >= 0) & (i_delts < N) & (j_delts >= 0) & (j_delts < N) & (delta_i != 0) & (delta_j != 0)
            i_delts = i_delts[inds]
            j_delts = j_delts[inds]
            antinodes[i_delts, j_delts] = '#'
print(d_ij)
print(antinodes)
print((antinodes=='#').sum())
