import numpy as np

def get_perimeter(d_ij, indices):
    n = 0
    perimeter = []
    for i, j in indices:
        if i == 1:
            n += 1
            for jj in range(j-1, j+2):
                perimeter += [(0, jj)]
            if d_ij[i,j] != d_ij[i+2,j]:
                n += 1
                for jj in range(j-1, j+2):
                    perimeter += [(i+1, jj)]
        elif i == (len(d_ij) - 2):
            n += 1
            for jj in range(j-1, j+2):
                perimeter += [(len(d_ij)-1, jj)]
            if d_ij[i,j] != d_ij[i-2,j]:
                n += 1
                for jj in range(j-1, j+2):
                    perimeter += [(i-1, jj)]
        else:
            if d_ij[i,j] != d_ij[i-2,j]:
                n += 1
                for jj in range(j-1, j+2):
                    perimeter += [(i-1, jj)]
            if d_ij[i,j] != d_ij[i+2,j]:
                n += 1
                for jj in range(j-1, j+2):
                    perimeter += [(i+1, jj)]
        if j == 1:
            n += 1
            for ii in range(i-1, i+2):
                perimeter += [(ii, 0)]
            if d_ij[i,j] != d_ij[i,j+2]:
                n += 1
                for ii in range(i-1, i+2):
                    perimeter += [(ii, j+1)]
        elif j == len(d_ij) - 2:
            n += 1
            for ii in range(i-1, i+2):
                perimeter += [(ii, len(d_ij) -1)]
            if d_ij[i,j] != d_ij[i,j-2]:
                n += 1
                for ii in range(i-1, i+2):
                    perimeter += [(ii, j-1)]
        else:
            if d_ij[i,j] != d_ij[i,j-2]:
                n += 1
                for ii in range(i-1, i+2):
                    perimeter += [(ii, j-1)]
            if d_ij[i,j] != d_ij[i,j+2]:
                n += 1
                for ii in range(i-1, i+2):
                    perimeter += [(ii, j+1)]
    return n, perimeter


def get_sides(d_ij, indices):
    n = 0
    i_s = []
    j_s = []
    for ind in indices:
        i_s.append(ind[0])
        j_s.append(ind[1])
    return n

def get_region(d_ij, i0, j0):
    members = [(i0, j0)]
    while True:
        no_new = True
        for m in members:
            i, j = m
            if (i != 1) & ( (i-2,j) not in members):
                if d_ij[i,j] == d_ij[i-2,j]:
                    members.append( (i-2, j) )
                    no_new = False
            if (i != len(d_ij) - 2) & ((i+2,j) not in members):
                if d_ij[i,j] == d_ij[i+2,j]:
                    members.append( (i+2, j) )
                    no_new = False
            if (j != 1) & ((i, j-2) not in members):
                if d_ij[i,j] == d_ij[i,j-2]:
                    members.append( (i, j-2) )
                    no_new = False
            if (j != len(d_ij) - 2) & ((i, j+2) not in members):
                if d_ij[i,j] == d_ij[i,j+2]:
                    members.append( (i, j+2) )
                    no_new = False
        if no_new:
            break
    return members



with open('12.txt') as f:
    d = f.readlines()

for i in range(len(d)):
    d[i] = d[i].strip()

d_ij = np.zeros((len(d)*2+1, len(d)*2+1), dtype=str)
d_ij[:,:] = ' '

for i in range(len(d)):
    for j in range(len(d)):
        d_ij[2*i+1,2*j+1] = d[i][j]



vals, Ns = np.unique(d_ij, return_counts=True)

price = 0
price2 = 0
counted = []

for v in vals:
    if v == ' ':
        continue
    inds = np.where(d_ij == v)

    i_s, j_s = inds
    for i, j in zip(i_s, j_s):
        peri_arr = np.zeros(d_ij.shape, dtype=str)
        peri_arr = np.copy(d_ij)
        if (i,j) in counted:
            continue
        new_region = get_region(d_ij, i, j)
        N = len(new_region)
        L, perimeter = get_perimeter(d_ij, new_region)
        perimeter = list(set(tuple(p) for p in perimeter))
        price += N*L
        for p in perimeter:
            if (p[0] == 0) & (p[1] == 0):
                peri_arr[p[0], p[1]] = '*'
            elif (p[0] == 0) & (p[1] == len(d_ij)-1):
                peri_arr[p[0], p[1]] = '*'
            elif (p[0] == len(d_ij)-1) & (p[1] == 0):
                peri_arr[p[0], p[1]] = '*'
            elif (p[0] == len(d_ij)-1) & (p[1] == len(d_ij)-1):
                peri_arr[p[0], p[1]] = '*'
            elif p[0] == 0:
                if ((p[0], p[1]+1) in perimeter) & ((p[0], p[1]-1) in perimeter):
                    peri_arr[p[0], p[1]] = '-'
                else:
                    peri_arr[p[0], p[1]] = '*'
            elif p[0] == len(d_ij)-1:
                if ((p[0], p[1]+1) in perimeter) & ((p[0], p[1]-1) in perimeter):
                    peri_arr[p[0], p[1]] = '-'
                else:
                    peri_arr[p[0], p[1]] = '*'
            elif p[1] == 0:
                if ((p[0]+1, p[1]) in perimeter) & ((p[0]-1, p[1]) in perimeter):
                    peri_arr[p[0], p[1]] = '|'
                else:
                    peri_arr[p[0], p[1]] = '*'
            elif p[1] == len(d_ij)-1:
                if ((p[0]+1, p[1]) in perimeter) & ((p[0]-1, p[1]) in perimeter):
                    peri_arr[p[0], p[1]] = '|'
                else:
                    peri_arr[p[0], p[1]] = '*'
            else:
                if ((p[0], p[1]+1) in perimeter) & ((p[0], p[1]-1) in perimeter) & ((p[0]+1, p[1]) in perimeter) & ((p[0]-1, p[1]) in perimeter):
                    peri_arr[p[0], p[1]] = '&'
                elif ((p[0], p[1]+1) in perimeter) & ((p[0], p[1]-1) in perimeter):
                    peri_arr[p[0], p[1]] = '-'
                elif ((p[0]+1, p[1]) in perimeter) & ((p[0]-1, p[1]) in perimeter):
                    peri_arr[p[0], p[1]] = '|'
                else:
                    peri_arr[p[0], p[1]] = '*'

        price2 += N*((peri_arr=='*').sum() + (peri_arr=='&').sum()*2)
        get_sides(d_ij, new_region)

        counted += new_region
print(price)
print(price2)
