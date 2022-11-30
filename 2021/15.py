import numpy as np
from tqdm import tqdm

data = np.loadtxt('data/15_ex.txt')

#data = np.loadtxt('data/15.txt')


# Need to implement dijkstra's algorithm


cost = np.ones_like(data)*np.inf
cost[0,0] = 0

visited = np.zeros_like(data, dtype='bool')
visited[0,0] = True

i0, j0 = 0,0
while True:
    if cost[i0+1, j0] > cost[i0, j0] + data[i0+1, j0]:
        cost[i0+1, j0] = cost[i0, j0] + data[i0+1, j0]
    if cost[i0, j0+1] > cost[i0, j0] + data[i0, j0+1]:
        cost[i0, j0+1] = cost[i0, j0] + data[i0, j0+1]
    if visited.sum() == cost.size:
        break

    print(cost)
    print(i0, j0)

    mins = np.where(cost == cost[~visited].min())
    print(mins, cost[~visited].min())
    print(visited)
    if len(mins[0]) == 1:
        i0, j0 = mins
    else:
        for i in range(len(mins)):
            print(mins[i], ~visited[mins[i][0], mins[i][1]])
            if ~visited[mins[i][0], mins[i][1]]:
                i0, j0 = mins[i]
                print(i0, j0, 'new')
                break
    visited[i0,j0] = True

print(cost)
