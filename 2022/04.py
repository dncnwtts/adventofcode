import numpy as np

data = np.loadtxt('input04.txt', dtype=str)

n = 0
for i in range(len(data)):
    p1, p2 = data[i].split(',')
    p1_min, p1_max = p1.split('-')
    p1_min = int(p1_min)
    p1_max = int(p1_max)
    p2_min, p2_max = p2.split('-')
    p2_min = int(p2_min)
    p2_max = int(p2_max)
    if (p1_min >= p2_min) and (p1_max <= p2_max):
        n += 1
    elif (p2_min >= p1_min) and (p2_max <= p1_max):
        n += 1

print(n)

n = 0
for i in range(len(data)):
    p1, p2 = data[i].split(',')
    p1_min, p1_max = p1.split('-')
    p1_min = int(p1_min)
    p1_max = int(p1_max)
    p2_min, p2_max = p2.split('-')
    p2_min = int(p2_min)
    p2_max = int(p2_max)
    if (p1_max >= p2_min) and (p1_max <= p2_max):
        n += 1
    elif (p2_max >= p1_min) and (p2_max <= p1_max):
        n += 1
print(n)
