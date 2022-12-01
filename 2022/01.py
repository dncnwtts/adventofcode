import numpy as np

f = open('input01.txt', 'r')
lines = f.readlines()

cal_list = [0]
for line in lines:
    x = line.strip()
    if x == '':
        cal_list.append(0)
    else:
        cal_list[-1] += int(x)
print(max(cal_list))

cal_list.sort()

print(sum(cal_list[-3:]))
