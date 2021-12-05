import numpy as np

data = np.loadtxt('data/05_ex.txt', dtype=str)
data = np.loadtxt('data/05.txt', dtype=str)

def get_lims(data):
    xmin, ymin, xmax, ymax = np.inf, np.inf, -np.inf, -np.inf
    for i in range(len(data)):
        x, y = np.array(data[i][0].split(',')).astype('int')
        if x < xmin:
            xmin = x
        if y < ymin:
            ymin = y
        if x > xmax:
            xmax = x
        if y > ymax:
            ymax = y
        x, y = np.array(data[i][0].split(',')).astype('int')
        if x < xmin:
            xmin = x
        if y < ymin:
            ymin = y
        if x > xmax:
            xmax = x
        if y > ymax:
            ymax = y
    return xmin, xmax, ymin, ymax

xmin, xmax, ymin, ymax = get_lims(data)

grid = np.zeros((xmax+1, ymax+1))


def fill_grid(grid, line):
    x0, y0 = np.array(line[0].split(',')).astype('int')
    x1, y1 = np.array(line[2].split(',')).astype('int')


    if (x0 == x1) or (y0 == y1):
        x0, x1 = min(x0,x1), max(x0, x1)
        y0, y1 = min(y0,y1), max(y0, y1)
        grid[x0:x1+1, y0:y1+1] += 1
    return

for i in range(len(data)):
    fill_grid(grid, data[i])
print(len(grid[grid > 1]))


def fill_grid(grid, line):
    x0, y0 = np.array(line[0].split(',')).astype('int')
    x1, y1 = np.array(line[2].split(',')).astype('int')

    if (x0 == x1) or (y0 == y1):
        x0, x1 = min(x0,x1), max(x0, x1)
        y0, y1 = min(y0,y1), max(y0, y1)
        grid[x0:x1+1, y0:y1+1] += 1
    else:
        if (x1 > x0) and (y1 > y0):
            for i in range(abs(x1-x0)+1):
                grid[int(x0+i),int(y0+i)] += 1
        elif (x1 < x0) and (y1 > y0):
            for i in range(abs(x1-x0)+1):
                grid[int(x0-i),int(y0+i)] += 1
        elif (x1 > x0) and (y1 < y0):
            for i in range(abs(x1-x0)+1):
                grid[int(x0+i),int(y0-i)] += 1
        else:
            for i in range(abs(x1-x0)+1):
                grid[int(x0-i),int(y0-i)] += 1
    return

grid = np.zeros((xmax+1, ymax+1))
for i in range(len(data)):
    fill_grid(grid, data[i])
print(len(grid[grid > 1]))
