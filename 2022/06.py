import numpy as np
buff = np.loadtxt('input06.txt', dtype=str)[()]

for i in range(4, len(buff)):
    if len(set(buff[i-4:i])) == 4:
        print(i)
        break

for i in range(14, len(buff)):
    if len(set(buff[i-14:i])) == 14:
        print(i)
        break
