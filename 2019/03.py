import numpy as np
import matplotlib.pyplot as plt


def get_full_path(path):
    turns = path.split(',')
    pos = [[0,0]]
    l = 0
    for t in turns:
        if t[0] == 'R':
            p2 = [pos[-1][0] + int(t[1:]), pos[-1][1]]
        elif t[0] == 'U':
            p2 = [pos[-1][0], pos[-1][1] + int(t[1:])]
        elif t[0] == 'L':
            p2 = [pos[-1][0] - int(t[1:]), pos[-1][1]]
        elif t[0] == 'D':
            p2 = [pos[-1][0], pos[-1][1] - int(t[1:])]
        dx = p2[0] - pos[-1][0] 
        dy = p2[1] - pos[-1][1]
        l += int(t[1:])
        while abs(dx) > 0:
            p3 = [pos[-1][0] + np.sign(dx), pos[-1][1]]
            pos.append(p3)
            dx = p2[0] - pos[-1][0] 
        while abs(dy) > 0:
            p3 = [pos[-1][0], pos[-1][1] + np.sign(dy)]
            pos.append(p3)
            dy = p2[1] - pos[-1][1] 
    return pos, np.arange(l)

dirs = np.loadtxt('input03.txt', dtype=str)
dirs1 = dirs[0]
dirs2 = dirs[1]
#dirs1 = 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51'
#dirs1 = 'R75,D30,R83,U83,L12,D49,R71,U7,L72'
path1, l1 =  get_full_path(dirs1)
path1 = np.array(path1)
plt.plot(path1[:,0], path1[:,1], 'o-')
#dirs2 = 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
#dirs2 = 'U62,R66,U55,R34,D71,R55,D58,R83'
path2, l2 = get_full_path(dirs2)
path2 = np.array(path2)
plt.plot(path2[:,0], path2[:,1], 'o-')


minval = np.inf
dists1 = abs(path1[:,0]) + abs(path1[:,1])
dists2 = abs(path2[:,0]) + abs(path2[:,1])
bla1 = np.argsort(dists1)
bla2 = np.argsort(dists2)
path1_ = path1[bla1]
path2_ = path2[bla2]
dists1_ = dists1[bla1]
dists2_ = dists2[bla2]
bla, inds1, inds2 = np.intersect1d(dists1_, dists2_, return_indices=True)



from tqdm import tqdm
#for i in tqdm(range(1,len(path1_[inds1]))):
#    if path1_[i] in path2_:
#        for j in range(1,len(path2_[inds2])):
#            if np.all(path1_[i] == path2_[j]):
#                if dists1_[i] < minval:
#                    minval = dists1_[i]
#                    print(minval)
#                    break
#

minval = np.inf
dists1 = l1
dists2 = l2
dists1 = abs(path1[:,0]) + abs(path1[:,1])
dists2 = abs(path2[:,0]) + abs(path2[:,1])
bla1 = np.argsort(dists1)
bla2 = np.argsort(dists2)
path1_ = path1[bla1]
path2_ = path2[bla2]
dists1_ = dists1[bla1]
dists2_ = dists2[bla2]
bla, inds1, inds2 = np.intersect1d(dists1_, dists2_, return_indices=True)
for i in tqdm(range(1,len(path1_[inds1]))):
    if path1_[i] in path2_:
        for j in range(1,len(path2_[inds2])):
            if np.all(path1_[i] == path2_[j]):
                if dists1_[i] + dists2_[j]< minval:
                    minval = dists1_[i] + dists2_[j]
                    print(minval)
