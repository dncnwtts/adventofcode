import numpy as np

data = np.loadtxt('data/11_ex_2.txt')
#data = np.loadtxt('data/11_ex_1.txt')
data = np.loadtxt('data/11.txt')

data = np.pad(data,1).astype('int')


steps = 195

num_flashes = 0

step = 0
while True:
    step += 1
    flashed = np.zeros(data.shape, dtype='bool')
    data += 1
    totinds = (data > 9)
    while True:
        inds = (data > 9)
        if inds[1:len(data)-1,1:len(data[0])-1].sum() == 0:
            break
        for i in range(1,len(data)-1):
            for j in range(1,len(data[0])-1):
                if inds[i,j] and ~flashed[i,j]:
                    num_flashes += 1
                    data[i+1,j] += 1
                    data[i-1,j] += 1
                    data[i,j+1] += 1
                    data[i,j-1] += 1
                    data[i+1,j+1] += 1
                    data[i-1,j+1] += 1
                    data[i-1,j-1] += 1
                    data[i+1,j-1] += 1
                    flashed[i,j] = True
        data[flashed] = 0
    if data[1:len(data)-1,1:len(data[0])-1].sum() == 0:
        print(step)
        break
    if step == 100:
        print(num_flashes)
