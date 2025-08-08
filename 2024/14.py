import numpy as np
import matplotlib.pyplot as plt

with open('14.txt') as f:
    d = f.readlines()


robot_pos = []
robot_vel = []
Nx, Ny = 101, 103
grid = np.zeros((Ny, Nx), dtype=int)
N = 100
quadrants = np.zeros(4, dtype=int)
for i in range(len(d)):
    p, v = d[i].split('v=')
    p = p[2:]
    px, py = p.split(',')
    vx, vy = v.strip().split(',')

    robot_pos.append([int(px), int(py)])
    robot_vel.append([int(vx), int(vy)])

    px_100 = (int(px) + N*int(vx)) % Nx
    py_100 = (int(py) + N*int(vy)) % Ny

    grid[py_100, px_100] += 1

    # Quadrant check;
    if (px_100 < Nx//2) & (py_100 < Ny//2):
        quadrants[0] += 1
    elif (px_100 < Nx//2) & (py_100 > Ny//2):
        quadrants[1] += 1
    elif (px_100 > Nx//2) & (py_100 < Ny//2):
        quadrants[2] += 1
    elif (px_100 > Nx//2) & (py_100 > Ny//2):
        quadrants[3] += 1
    else:
        continue

print(quadrants)

print(np.prod(quadrants))

from tqdm import tqdm
for N in tqdm(range(1, 100_000_000)):
    grid = np.zeros((Ny, Nx), dtype=int)
    Ni = N
    quadrants = np.zeros(4, dtype=int)
    for i in range(len(d)):

        robot_pos[i][0] = (robot_pos[i][0] + robot_vel[i][0]) % Nx
        robot_pos[i][1] = (robot_pos[i][1] + robot_vel[i][1]) % Ny


        grid[robot_pos[i][1], robot_pos[i][0]] += 1

        px_100 = robot_pos[i][1]
        py_100 = robot_pos[i][0]
    
        # Quadrant check;
        if (px_100 < Nx//2) & (py_100 < Ny//2):
            quadrants[0] += 1
        elif (px_100 < Nx//2) & (py_100 > Ny//2):
            quadrants[1] += 1
        elif (px_100 > Nx//2) & (py_100 < Ny//2):
            quadrants[2] += 1
        elif (px_100 > Nx//2) & (py_100 > Ny//2):
            quadrants[3] += 1
        else:
            continue
    if (Ni % 100) == 0:
        inds = np.where(grid != 0)
        plt.imshow(grid.astype(bool))
        plt.title(f'{np.prod(quadrants)}')
        plt.savefig(f'N_{Ni:08}.png', dpi=150)
        plt.close()
    if np.prod(quadrants) < 50_000_000:
        break
