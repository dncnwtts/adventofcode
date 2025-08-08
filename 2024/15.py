import numpy as np

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


loop_max = 100
def print_block(d_ij, fname=None, move=None):
    if fname is None:
        for k in range(len(d_ij)):
            for l in range(len(d_ij[0])):
                if d_ij[k][l] == '@':
                    print(f'{bcolors.FAIL}{d_ij[k][l]}{bcolors.ENDC}', end='')
                else:
                    print(d_ij[k][l], end='')
            print()
        print()
    else:
        with open(fname, 'w') as f:
            print(move, file=f)
            for k in range(len(d_ij)):
                for l in range(len(d_ij[0])):
                    print(d_ij[k][l], end='', file=f)
                print(file=f)
            print(file=f)

def move_robot(d_ij, move):
    ind_x, ind_y = np.where(d_ij == '@')
    ind_x = ind_x[0]
    ind_y = ind_y[0]
    if move == '^':
        if d_ij[ind_x - 1][ind_y] == '#':
            return d_ij
        elif d_ij[ind_x - 1][ind_y] == '.':
            d_ij[ind_x-1][ind_y], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x-1][ind_y]
        elif d_ij[ind_x - 1][ind_y] == 'O':
            # try to push
            next_ind = ind_x - 1
            while True:
                if d_ij[next_ind, ind_y] == '#':
                    return d_ij
                elif d_ij[next_ind, ind_y] == 'O':
                    next_ind -= 1
                elif d_ij[next_ind, ind_y] == '.':
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[next_ind:ind_x, ind_y] = 'O'
                    d_ij[ind_x-1, ind_y] = '@'
                    return d_ij
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij
    elif move == 'v':
        # do thing
        if d_ij[ind_x + 1][ind_y] == '#':
            return d_ij
        elif d_ij[ind_x + 1][ind_y] == '.':
            d_ij[ind_x+1][ind_y], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x+1][ind_y]
        elif d_ij[ind_x + 1][ind_y] == 'O':
            # try to push
            next_ind = ind_x + 1
            while True:
                if d_ij[next_ind, ind_y] == '#':
                    return d_ij
                elif d_ij[next_ind, ind_y] == 'O':
                    next_ind += 1
                elif d_ij[next_ind, ind_y] == '.':
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x+2:next_ind+1, ind_y] = 'O'
                    d_ij[ind_x+1, ind_y] = '@'
                    return d_ij
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij
    elif move == '<':
        # do thing
        if d_ij[ind_x][ind_y-1] == '#':
            return d_ij
        elif d_ij[ind_x][ind_y-1] == '.':
            d_ij[ind_x][ind_y-1], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x][ind_y-1]
        elif d_ij[ind_x][ind_y-1] == 'O':
            # try to push
            next_ind = ind_y - 1
            while True:
                if d_ij[ind_x, next_ind] == '#':
                    return d_ij
                elif d_ij[ind_x, next_ind] == 'O':
                    next_ind -= 1
                elif d_ij[ind_x, next_ind] == '.':
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x, next_ind:ind_y] = 'O'
                    d_ij[ind_x, ind_y-1] = '@'
                    return d_ij
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij
    elif move == '>':
        if d_ij[ind_x][ind_y+1] == '#':
            return d_ij
        elif d_ij[ind_x][ind_y+1] == '.':
            d_ij[ind_x][ind_y+1], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x][ind_y+1]
        elif d_ij[ind_x][ind_y+1] == 'O':
            # try to push
            next_ind = ind_y + 1
            while True:
                if d_ij[ind_x, next_ind] == '#':
                    return d_ij
                elif d_ij[ind_x, next_ind] == 'O':
                    next_ind += 1
                elif d_ij[ind_x, next_ind] == '.':
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x, ind_y+2:next_ind+1] = 'O'
                    d_ij[ind_x, ind_y+1] = '@'
                    return d_ij
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij


    else:
        print('Something is wrong')
    return d_ij


bigbox = ['[', ']']

def move_robot2(d_ij, move, output=False):
    box_move = False
    ind_x, ind_y = np.where(d_ij == '@')
    ind_x = ind_x[0]
    ind_y = ind_y[0]
    d_ij_orig = np.copy(d_ij)
    if move == '^':
        if d_ij[ind_x - 1][ind_y] == '#':
            return d_ij, box_move
        elif d_ij[ind_x - 1][ind_y] == '.':
            d_ij[ind_x-1][ind_y], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x-1][ind_y]
            return d_ij, box_move
        elif d_ij[ind_x - 1][ind_y] in bigbox:
            # try to push
            next_ind = ind_x - 1
            moved_cols = []
            while True:
                if d_ij[next_ind, ind_y] == '#':
                    return d_ij, box_move
                elif d_ij[next_ind, ind_y] in bigbox:
                    next_ind -= 1
                elif d_ij[next_ind, ind_y] == '.':
                    if d_ij[next_ind+1,ind_y] == '[':
                        if d_ij[next_ind+1,ind_y+1] == '#':
                            return d_ij, box_move
                    if d_ij[next_ind+1,ind_y] == ']':
                        if d_ij[next_ind+1,ind_y-1] == '#':
                            return d_ij, box_move


                    if output: print_block(d_ij)
                    d_ij[next_ind:ind_x, ind_y] = d_ij[next_ind+1:ind_x+1, ind_y]
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x-1, ind_y] = '@'

                    if d_ij[ind_x-2, ind_y] == '[':
                        d_ij[ind_x-2, ind_y+1] = d_ij[ind_x-1, ind_y+1]
                        d_ij[ind_x-1, ind_y+1] = '.'
                    if d_ij[ind_x-2, ind_y] == ']':
                        d_ij[ind_x-2, ind_y-1] = d_ij[ind_x-1, ind_y-1]
                        d_ij[ind_x-1, ind_y-1] = '.'

                    if output: print_block(d_ij)

                    bad_move = False
                    bigloop_count = 0
                    while True:
                        while True:
                            num = 0
                            inds = np.where(d_ij == '[')
                            i_s, j_s = inds
                            j_s = j_s[np.argsort(i_s)[::-1]]
                            i_s = i_s[np.argsort(i_s)[::-1]]
                            for i_, j_ in zip(i_s, j_s):
                                if d_ij[i_, j_+1] == ']':
                                    continue
                                if (j_ != ind_y) | (i_ != ind_x-2):
                                    if d_ij[i_-1, j_+1] != ']':
                                        continue
                                    max_height = np.where(d_ij[:,j_] == '.')[0]
                                    max_height.sort()
                                    m = max_height[max_height < i_]
                                    if len(m) != 0:
                                        m = m[-1]
                                    else:
                                        bad_move = True
                                        break
                                    if np.any(d_ij[m+1:i_+1, j_] == '#'):
                                        bad_move = True
                                    d_ij[m:i_, j_] = d_ij[m+1:i_+1, j_]
                                    d_ij[i_, j_] = '.'
                                    box_move = True
                                    num += 1
                                    moved_cols.append(j_)
                                    break
                            if num == 0:
                                break
                        while True:
                            num = 0
                            inds = np.where(d_ij == ']')
                            i_s, j_s = inds
                            j_s = j_s[np.argsort(i_s)[::-1]]
                            i_s = i_s[np.argsort(i_s)[::-1]]
                            for i_, j_ in zip(i_s, j_s):
                                if d_ij[i_, j_-1] == '[':
                                    continue
                                if (j_ != ind_y) | (i_ != ind_x-2) | True:
                                    if d_ij[i_-1, j_-1] != '[':
                                        continue
                                    max_height = np.where(d_ij[:,j_] == '.')[0]
                                    max_height.sort()
                                    m = max_height[max_height < i_]
                                    if len(m) != 0:
                                        m = m[-1]
                                    else:
                                        bad_move = True
                                        break
                                    if np.any(d_ij[m+1:i_+1, j_] == '#'):
                                        bad_move = True
                                    d_ij[m:i_, j_] = d_ij[m+1:i_+1, j_]
                                    d_ij[i_, j_] = '.'
                                    box_move = True
                                    num += 1
                                    moved_cols.append(j_)
                                    break
                            if num == 0:
                                break
                            

                        inds = np.where(d_ij == '[')
                        i_s, j_s = inds
                        num = 0
                        for i_, j_ in zip(i_s, j_s):
                            if d_ij[i_,j_+1] != ']':
                                num += 1
                        if num == 0:
                            break
                        else:
                           bigloop_count += 1

                        if bigloop_count > loop_max:
                            bad_move = True
                            break
                    if bad_move:
                        box_move = False
                        d_ij = d_ij_orig
                    return d_ij, box_move
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij, box_move
    elif move == 'v':
        if d_ij[ind_x + 1][ind_y] == '#':
            return d_ij, box_move
        elif d_ij[ind_x + 1][ind_y] == '.':
            d_ij[ind_x+1][ind_y], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x+1][ind_y]
            return d_ij, box_move
        elif d_ij[ind_x + 1][ind_y] in bigbox:
            # try to push
            next_ind = ind_x + 1
            while True:
                if d_ij[next_ind, ind_y] == '#':
                    return d_ij, box_move
                elif d_ij[next_ind, ind_y] in bigbox:
                    next_ind += 1
                elif d_ij[next_ind, ind_y] == '.':
                    if d_ij[next_ind-1,ind_y] == '[':
                        if d_ij[next_ind-1,ind_y+1] == '#':
                            return d_ij, box_move
                    if d_ij[next_ind-1,ind_y] == ']':
                        if d_ij[next_ind-1,ind_y-1] == '#':
                            return d_ij, box_move


                    d_ij[ind_x+1:next_ind+1, ind_y] = d_ij[ind_x:next_ind, ind_y]
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x+1, ind_y] = '@'

                    bad_move = False
                    bigloop_count = 0
                    while True:
                        while True:
                            num = 0
                            inds = np.where(d_ij == '[')
                            i_s, j_s = inds
                            for i_, j_ in zip(i_s, j_s):
                                if (d_ij[i_, j_+1] != ']') & (j_ != ind_y):
                                    max_height = np.where(d_ij[:,j_] == '.')[0]
                                    max_height.sort()
                                    m = max_height[max_height > i_]
                                    if len(m) != 0:
                                        m = m[0]
                                    else:
                                        bad_move = True
                                        break
                                    if np.any(d_ij[i_:m, j_] == '#'):
                                        bad_move = True
                                    d_ij[i_+1:m+1, j_] = d_ij[i_:m, j_]
                                    d_ij[i_, j_] = '.'
                                    box_move = True
                                    num += 1
                                    break
                            if num == 0:
                                break

                        while True:
                            num = 0
                            inds = np.where(d_ij == ']')
                            i_s, j_s = inds
                            for i_, j_ in zip(i_s, j_s):
                                if d_ij[i_, j_-1] == '[':
                                    continue
                                if (d_ij[i_, j_-1] != '[') | (j_ != ind_y):
                                    max_height = np.where(d_ij[:,j_] == '.')[0]
                                    max_height.sort()
                                    m = max_height[max_height > i_]
                                    if len(m) != 0:
                                        m = m[0]
                                    else:
                                        bad_move = True
                                        break
                                    if np.any(d_ij[i_:m, j_] == '#'):
                                        bad_move = True
                                    d_ij[i_+1:m+1, j_] = d_ij[i_:m, j_]
                                    d_ij[i_, j_] = '.'
                                    box_move = True
                                    num += 1
                                    break
                            if num == 0:
                                break
                        inds = np.where(d_ij == '[')
                        i_s, j_s = inds
                        num = 0
                        for i_, j_ in zip(i_s, j_s):
                            if d_ij[i_,j_+1] != ']':
                                num += 1
                        if num == 0:
                            break
                        else:
                           bigloop_count += 1

                        if bigloop_count > loop_max:
                            bad_move = True
                            break
                    if bad_move:
                        box_move = False
                        d_ij = d_ij_orig
                    return d_ij, box_move
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij, box_move
    elif move == '<':
        # do thing
        if d_ij[ind_x][ind_y-1] == '#':
            return d_ij, box_move
        elif d_ij[ind_x][ind_y-1] == '.':
            d_ij[ind_x][ind_y-1], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x][ind_y-1]
            return d_ij, box_move
        elif d_ij[ind_x][ind_y-1] in bigbox:
            # try to push
            next_ind = ind_y - 1
            while True:
                if d_ij[ind_x, next_ind] == '#':
                    return d_ij, box_move
                elif d_ij[ind_x, next_ind] in bigbox:
                    next_ind -= 1
                elif d_ij[ind_x, next_ind] == '.':
                    box_move = True
                    d_ij[ind_x, next_ind:ind_y] = d_ij[ind_x, next_ind+1:ind_y+1]
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x, ind_y-1] = '@'
                    return d_ij, box_move
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij, box_move
    elif move == '>':
        if d_ij[ind_x][ind_y+1] == '#':
            return d_ij, box_move
        elif d_ij[ind_x][ind_y+1] == '.':
            d_ij[ind_x][ind_y+1], d_ij[ind_x][ind_y] =  d_ij[ind_x][ind_y], d_ij[ind_x][ind_y+1]
        elif d_ij[ind_x][ind_y+1] in bigbox:
            # try to push
            next_ind = ind_y + 1
            while True:
                if d_ij[ind_x, next_ind] == '#':
                    return d_ij, box_move
                elif d_ij[ind_x, next_ind] in bigbox:
                    next_ind += 1
                elif d_ij[ind_x, next_ind] == '.':
                    box_move = True
                    d_ij[ind_x, ind_y+2:next_ind+1] = d_ij[ind_x, ind_y+1:next_ind]
                    d_ij[ind_x, ind_y] = '.'
                    d_ij[ind_x, ind_y+1] = '@'
                    return d_ij, box_move
                else:
                    print('Something strange is happening')
                    print(d_ij[ind_x, next_ind])
                    return d_ij, box_move


    else:
        print('Something is wrong')
    return d_ij, box_move

with open('15.txt') as f:
    d = f.readlines()

max_ind = None
for i in range(len(d)):
    d[i] = d[i].strip()
    if (d[i] == '') and max_ind is None:
        max_ind = i

print('max ind', max_ind)
print('d length', len(d))

d_ij = np.zeros((max_ind, len(d[0])), dtype=str)

for i in range(len(d_ij)):
    for j in range(len(d_ij[0])):
        d_ij[i][j] = d[i][j]

print(d_ij.shape)
for k in range(len(d_ij)):
    for l in range(len(d_ij[0])):
        print(d_ij[k][l], end='')
    print()
print()

moves = ''
for i in range(len(d_ij), len(d)):
    moves = moves + d[i]


for i in range(len(moves)):
    d_ij = move_robot(d_ij, moves[i])
for k in range(len(d_ij)):
    for l in range(len(d_ij[0])):
        print(d_ij[k][l], end='')
    print()
print()

box_locs = np.where(d_ij == 'O')
box_x, box_y = box_locs[0], box_locs[1]
gps_coord = 0
for i in range(len(box_x)):
    gps_coord += box_x[i]*100 + box_y[i]
print(gps_coord, 'answer 1')


d_ij = np.zeros((max_ind, 2*len(d[0])), dtype=str)

for i in range(len(d_ij)):
    for j in range(len(d_ij[0])//2):
        if d[i][j] == 'O':
           d_ij[i][2*j] = '['
           d_ij[i][2*j+1] = ']'
        elif d[i][j] == '@':
           d_ij[i][2*j] = '@'
           d_ij[i][2*j+1] = '.'
        else:
           d_ij[i][2*j] = d[i][j]
           d_ij[i][2*j+1] = d[i][j]



block_inds = np.where(d_ij == '#')
i_sum, j_sum = block_inds[0].sum(), block_inds[1].sum()

num_left = (d_ij == '[').sum()
num_right = (d_ij == ']').sum()

print_block(d_ij)


#for i in range(200):
from tqdm import tqdm
#for i in tqdm(range(len(moves))):
for i in tqdm(range(300)):
    d_ij, m = move_robot2(d_ij, moves[i], output=(i==298))

    ##if m:
    if (i % 1) == 0:
        print_block(d_ij, fname=f'{i:05}_output.txt', move=moves[i])
    block_inds = np.where(d_ij == '#')
    if i_sum != block_inds[0].sum():
        print('block error x')
        break
    if j_sum != block_inds[1].sum():
        print('block error x')
        break

    num_left2 = (d_ij == '[').sum()
    num_right2 = (d_ij == ']').sum()
    if num_left2 != num_left:
        print('box error, left')
        break
    if num_right2 != num_right:
        print('box error, right')
        break
print_block(d_ij)

box_locs = np.where(d_ij == '[')
box_x, box_y = box_locs[0], box_locs[1]
gps_coord = 0
for i in range(len(box_x)):
    gps_coord += box_x[i]*100 + box_y[i]
print(gps_coord)

# 1455815 is too high
# 1433774 is too low
# 1432679 is too low
# 1391136 is definitely too low
