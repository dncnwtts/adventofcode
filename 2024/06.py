import numpy as np
from tqdm import tqdm

with open('06_ex.txt') as f:
    d_txt = f.readlines()

d = np.zeros((len(d_txt), len(d_txt)), dtype=str)

for i in range(len(d)):
    for j in range(len(d)):
        d[i][j] = d_txt[i][j]

inds = np.where(d == '^')
i0, j0 = inds[0][0], inds[1][0]
print(i0, j0)
symbols = ['^', '>', 'v', '<']

def traverse(d):
    d2 = [[ [] for i in range(len(d))] for j in range(len(d[0]))]
    symb_ind = 0
    x = np.where(d == '^')
    if len(x[0]) == 0:
        d[:,:] = '.'
        return d
    while True:
        if symbols[symb_ind % 4] == '^':
            x = np.where(d == '^')
            j, i = x[0][0], x[1][0]
            d2[j][i].append('^')
            if j == 0:
                d[j][i] = 'X'
                break
            x = np.where(d[:,i] == '#')
            if d[j-1][i] != '#':
                d[j][i] = 'X'
                d[j-1][i] = '^'
            else:
                d[j][i] = '>'
                symb_ind += 1
        elif symbols[symb_ind % 4] == '>':
            x = np.where(d == '>')
            j, i = x[0][0], x[1][0]
            d2[j][i].append('>')
            if i == len(d)-1:
                d[j][i] = 'X'
                break
            if d[j][i+1] != '#':
                d[j][i] = 'X'
                d[j][i+1] = '>'
            else:
                d[j][i] = 'v'
                symb_ind += 1
        elif symbols[symb_ind % 4] == 'v':
            x = np.where(d == 'v')
            j, i = x[0][0], x[1][0]
            d2[j][i].append('v')
            if j == (len(d)-1):
                d[j][i] = 'X'
                break
            if d[j+1][i] != '#':
                d[j][i] = 'X'
                d[j+1][i] = 'v'
            else:
                d[j][i] = '<'
                symb_ind += 1
        elif symbols[symb_ind % 4] == '<':
            x = np.where(d == '<')
            j, i = x[0][0], x[1][0]
            d2[j][i].append('<')
            if i == 0:
                d[j][i] = 'X'
                break
            if d[j][i-1] != '#':
                d[j][i] = 'X'
                d[j][i-1] = '<'
            else:
                d[j][i] = '^'
                symb_ind += 1
        else:
            print('Something is wrong')
            break
        if d2[j][i].count(symbols[(symb_ind - 1) % 4]) > 1:
            d[:,:] = '#'
            break
    return d

d = traverse(d)
x = (d == 'X')
print(x.sum())
d_ij = np.copy(d)
n = 0

checks = np.where(x)
ks, ls = checks[0], checks[1]
for _ in tqdm(range(len(ks))):
    k, l = ks[_], ls[_]
    if d[i,j] != '.':
        continue
    for i in range(len(d)):
        for j in range(len(d)):
            d_ij[i][j] = d_txt[i][j]
    d_ij[k][l] = '#'
    d_ij = traverse(d_ij)
    x = (d_ij == '#')
    if x.sum() == x.size:
        n += 1
print(n)
