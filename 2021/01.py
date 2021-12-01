import numpy as np

data = np.loadtxt('data/01_ex.txt')
data2 = [sum(data[i:i+3]) for i in range(len(data)-2)]
print(sum(np.sign(np.diff(data))>0))
print(sum(np.sign(np.diff(data2))>0))
data = np.loadtxt('data/01.txt')
data2 = [sum(data[i:i+3]) for i in range(len(data)-2)]
print(sum(np.sign(np.diff(data))>0))
print(sum(np.sign(np.diff(data2))>0))
