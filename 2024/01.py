import numpy as np

d = np.loadtxt('01.txt', dtype=int)
a, b = d.T
a.sort()
b.sort()

print(abs(a-b).sum())

sim_score = 0
for i in range(len(a)):
    sim_score += (b == a[i]).sum()*a[i]
print(sim_score)
