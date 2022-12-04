import numpy as np
import math

from fractions import Fraction

data = np.loadtxt('input10_ex.txt', dtype=str,  comments=None)
i0, j0 = 1, 0
k = 0
nums = np.zeros((len(data), len(data[0])), dtype=int)
for i0 in range(len(data)):
    for j0 in range(len(data[0])):
        slopes = []
        k = 0
        if data[j0][i0] == '.':
            continue
        for i in range(len(data)):
            for j in range(len(data[0])):
                dj = j - j0
                di = i - i0
                div = math.gcd(di,dj)
                if div == 0:
                    slope = (di, dj)
                else:
                    slope = (di//div, dj//div)
                if slope in slopes:
                    continue
                if di == 0 and dj == 0:
                    continue
                for n in range(1, max(len(data), len(data[0]))):
                    b1 = j0 + n*dj >= 0
                    b2 = j0 + n*dj <= len(data)-1
                    b3 = i0 + n*di >= 0
                    b4 = i0 + n*di <= len(data[0])-1
                    if b1 & b2 & b3 & b4:
                        if data[j0+n*dj][i0+n*di] == '#':
                            slopes.append(slope)
                            k += 1
                            break
        nums[j0,i0] = k

print(nums.max())
jmax, imax = np.where(nums == nums.max())
jmax, imax = jmax[0], imax[0]

import matplotlib.pyplot as plt
plt.imshow(nums, vmin=min(nums[nums > 0]))

ms = np.zeros_like(nums, dtype=float)
for i in range(len(data)):
    for j in range(len(data)):
        if i == imax and j < 0:
            ms[j,i] = -np.inf
        elif i == imax and j > 0:
            ms[j,i] = np.inf
        else:
            ms[j,i] = (j-jmax)/(i-imax)
plt.figure()
plt.imshow(ms, origin='lower')
plt.show()
