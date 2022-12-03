import numpy as np

s = np.loadtxt('input08.txt', dtype=str)[()]

N_layers = len(s)//25//6

layers = []
n_zeros = np.zeros(N_layers)
for i in range(N_layers):
    sub_string = s[25*6*i:25*6*(i+1)]
    n_zeros[i] = sub_string.count('0')
    #for j in range(6):
    #    print(sub_string[j*25:(j+1)*25])
    #print('\n')
    layers.append(sub_string)

ind = np.argmin(n_zeros)
sub_string = s[25*6*ind:25*6*(ind+1)]
print(sub_string.count('1')*sub_string.count('2'))



print('\n')
super_string = ''
for i in range(len(sub_string)):
    for j in range(len(layers)):
        if layers[j][i] == '2':
            continue
        else:
            if layers[j][i] == '0':
                super_string += ' '
            elif layers[j][i] == '1':
                super_string += '1'
            break

for j in range(6):
    print(super_string[j*25:(j+1)*25])
print('\n')
