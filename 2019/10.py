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

data2 = np.zeros_like(nums)
for i in range(len(data)):
    for j in range(len(data[0])):
        if data[i][j] == '#':
            data2[i][j] = 1

for i in range(len(data)):
    print(data[i])
for i in range(len(data)):
    print(data2[i])

import matplotlib.pyplot as plt
#plt.imshow(nums, vmin=min(nums[nums > 0]))

thetas = np.zeros_like(nums, dtype=float)
for i in range(len(data)):
    for j in range(len(data)):
            thetas[j,i] = np.arctan2(i-imax, -(j-jmax))
plt.figure()
plt.imshow(thetas, cmap='twilight')
#plt.imshow(thetas, origin='lower', cmap='twilight')

order = np.zeros_like(nums)
thetas = np.unique(thetas)[::-1]
x = np.linspace(1,len(data)*2, 1000000)
num = 0
b1 = False
while data2.max() == 1:
    print(order.max())
    for i in range(len(thetas)):
        i_cands = imax + x*np.cos(thetas[i]-np.pi/2)
        j_cands = jmax + x*np.sin(thetas[i]-np.pi/2)
        i_ints = i_cands.astype('int')
        j_ints = j_cands.astype('int')
        check = (abs(i_cands - i_ints) < 1e-5) & (abs(j_cands-j_ints) < 1e-5)
        j_ints = j_ints[check]
        i_ints = i_ints[check]
        for i_int, j_int in zip(i_ints, j_ints):
            b1 = j_int < 0
            b2 = j_int > len(data)-1
            b3 = i_int < 0
            b4 = i_int > len(data[0])-1
            if (b1 or b2 or b3 or b4):
                continue
            if data2[j_int][i_int] == 1:
                num += 1
                order[j_int][i_int] = num
                data2[j_int][i_int] = 0
                if num == 200:
                    print('hey')
                b1 = True
                break
            if b1:
                b1 = False
                break
                

plt.show()
