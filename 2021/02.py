import numpy as np

data = np.loadtxt('data/02_ex.txt', dtype='str')
data = np.loadtxt('data/02.txt', dtype='str')
print(np.unique(data[:,0]))
pos = {'depth':0,
       'horizontal':0,
	'aim': 0}

for i in range(len(data)):
	if data[i][0] == 'forward':
		pos['horizontal'] += int(data[i][1])
	elif data[i][0] == 'down':
		pos['depth'] += int(data[i][1])
	elif data[i][0] == 'up':
		pos['depth'] -= int(data[i][1])

print(pos['depth']*pos['horizontal'])

pos = {'depth':0,
       'horizontal':0,
	'aim': 0}
for i in range(len(data)):
	if data[i][0] == 'forward':
		pos['horizontal'] += int(data[i][1])
		pos['depth'] += int(data[i][1])*pos['aim']
	elif data[i][0] == 'down':
		pos['aim'] += int(data[i][1])
	elif data[i][0] == 'up':
		pos['aim'] -= int(data[i][1])
print(pos['depth']*pos['horizontal'])
