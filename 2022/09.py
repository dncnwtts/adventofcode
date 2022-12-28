import numpy as np
N = 1000

data =    [ ['.' for i in range(N)] for j in range(N)]
visited = [ ['.' for i in range(N)] for j in range(N)]
i0, j0 = N//2-1,N//2-1
i0_T, j0_T = N//2-1,N//2-1
data[i0_T][j0_T] = 'T'
visited[i0_T][j0_T] = '#'
visit_map = np.zeros((N,N))

f = open('input09.txt')
Lines = f.readlines()
for line in Lines:
    mov, n = line.split()
    n = int(n)
    data[i0][j0] = '.'
    if mov == 'R':
        lr, ud = True, False
        sgn = 1
    elif mov == 'L':
        lr, ud = True, False
        sgn = -1
    elif mov == 'U':
        lr, ud = False, True
        sgn = -1
    elif mov == 'D':
        lr, ud = False, True
        sgn = 1
    for i in range(n):
        if lr:
            data[i0][j0] = '.'
            data[i0][j0 + sgn] = 'H'
            j0 += sgn
        if ud:
            data[i0][j0] = '.'
            data[i0 + sgn][j0] = 'H'
            i0 += sgn

        data[i0_T][j0_T] = '.'
        di = i0 - i0_T
        dj = j0 - j0_T
        if abs(di) > 1 or abs(dj) > 1:
            if dj == 0:
                i0_T += di//abs(di)
            elif di == 0:
                j0_T += dj//abs(dj)
            else:
                i0_T += di//abs(di)
                j0_T += dj//abs(dj)
        data[i0_T][j0_T] = 'T'
        visited[i0_T][j0_T] = '#'
        #for d in data:
        #    print(d)
        #print('\n')
inc = 0
for i, v in enumerate(visited):
    for j, vi in enumerate(v):
        if vi == '#':
            inc += 1
            visit_map[i,j] = 1
print(inc)


i0, j0 = N//2-1,N//2-1
i_knots = np.ones(10, dtype=int)*i0
j_knots = np.ones(10, dtype=int)*j0

data =    [ ['.' for i in range(N)] for j in range(N)]
visited = [ ['.' for i in range(N)] for j in range(N)]
visited[i_knots[-1]][j_knots[-1]] = '#'
knot_labs = np.arange(1, len(i_knots))
visit_map = np.zeros((N,N))
f = open('input09.txt')
Lines = f.readlines()
for line in Lines:
    mov, n = line.split()
    n = int(n)
    data[i0][j0] = '.'
    if mov == 'R':
        lr, ud = True, False
        sgn = 1
    elif mov == 'L':
        lr, ud = True, False
        sgn = -1
    elif mov == 'U':
        lr, ud = False, True
        sgn = -1
    elif mov == 'D':
        lr, ud = False, True
        sgn = 1
    for i in range(n):
        if lr:
            data[i_knots[0]][j_knots[0]] = '.'
            data[i_knots[0]][j_knots[0] + sgn] = 'H'
            j_knots[0] += sgn
        if ud:
            data[i_knots[0]][j_knots[0]] = '.'
            data[i_knots[0] + sgn][j_knots[0]] = 'H'
            i_knots[0] += sgn
        for j in range(1,len(i_knots)):
            data[i_knots[j]][j_knots[j]] = '.'
            di = i_knots[j] - i_knots[j-1]
            dj = j_knots[j] - j_knots[j-1]
            if abs(di) > 1 or abs(dj) > 1:
                if dj == 0:
                    i_knots[j] -= di//abs(di)
                elif di == 0:
                    j_knots[j] -= dj//abs(dj)
                else:
                    i_knots[j] -= di//abs(di)
                    j_knots[j] -= dj//abs(dj)
            data[i_knots[j]][j_knots[j]] = str(knot_labs[j-1])
        visited[i_knots[-1]][j_knots[-1]] = '#'
inc = 0
for i, v in enumerate(visited):
    for j, vi in enumerate(v):
        if vi == '#':
            inc += 1
            visit_map[i,j] = 1
print(inc)
