import numpy as np

data = np.loadtxt('input01.txt')

reqs  = 0
for i in range(len(data)):
    reqs += int(data[i])//3 - 2
print(reqs)

reqs_tot = 0
for i in range(len(data)):
    reqs_tmp = int(data[i])//3 - 2
    while reqs_tmp >= 0:
        reqs_tot += reqs_tmp
        reqs_tmp = int(reqs_tmp)//3 - 2
print(reqs_tot)
