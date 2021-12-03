import numpy as np
from scipy.stats import mode

data = np.loadtxt('data/03_ex.txt')
data = np.loadtxt('data/03.txt')

epsilon_array = np.zeros(len(data[0]))
gamma_array = np.zeros(len(data[0]))
for i in range(len(data[0])):
    numbers, counts = np.unique(data[:,i], return_counts=True)
    if counts[0] > counts[1]:
        gamma_array[i], epsilon_array[i] = numbers[0], numbers[1]
    else:
        gamma_array[i], epsilon_array[i] = numbers[1], numbers[0]

gamma = 0
epsilon = 0
for i in range(len(gamma_array)):
    gamma += int((2**(len(gamma_array)-i-1)*gamma_array[i]))
    epsilon += int((2**(len(gamma_array)-i-1)*epsilon_array[i]))
print(gamma*epsilon)


for i in range(len(data[0])):
    if len(data) == 1:
        break
    numbers, counts = np.unique(data[:,i], return_counts=True)
    if counts[0] > counts[1]:
        data = data[data[:,i] == numbers[0]]
    else:
        data = data[data[:,i] == numbers[1]]
gamma_array = data[0]

data = np.loadtxt('data/03_ex.txt')
data = np.loadtxt('data/03.txt')
for i in range(len(data[0])):
    if len(data) == 1:
        break
    numbers, counts = np.unique(data[:,i], return_counts=True)
    if counts[0] <= counts[1]:
        data = data[data[:,i] == numbers[0]]
    else:
        data = data[data[:,i] == numbers[1]]
epsilon_array = data[0]

gamma = 0
epsilon = 0
for i in range(len(gamma_array)):
    gamma += int((2**(len(gamma_array)-i-1)*gamma_array[i]))
    epsilon += int((2**(len(gamma_array)-i-1)*epsilon_array[i]))
print(gamma*epsilon)
