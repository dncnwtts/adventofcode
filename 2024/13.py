import numpy as np



with open('13.txt') as f:
    d = f.readlines()

N = 0
A = np.zeros((2,2))
b = np.zeros(2)
for i in range(len(d)):
    if i % 4 == 0:
        # A
        X_offset, Y_offset = d[i].split(',')
        X_offset = X_offset.split('+')[1].strip()
        Y_offset = Y_offset.split('+')[1].strip()
        A[0,0] = int(X_offset)
        A[1,0] = int(Y_offset)
    if i % 4 == 1:
        # B
        X_offset, Y_offset = d[i].split(',')
        X_offset = X_offset.split('+')[1].strip()
        Y_offset = Y_offset.split('+')[1].strip()
        A[0,1] = int(X_offset)
        A[1,1] = int(Y_offset)
    if i % 4 == 2:
        s_xy = d[i].split(':')[1].strip()
        s_x, s_y = s_xy.split(',')
        s_x = s_x.split('=')[1]
        s_y = s_y.split('=')[1]
        b[0] = int(s_x)
        b[1] = int(s_y)

        X = np.linalg.solve(A,b)
        X_int = np.round(X) 
        if np.allclose(b, A.dot(X_int)):
            if (np.all((X <= 100) & (X >= 0))):
                N += X[0]*3 + X[1]
            else:
                print('X too large')
                print(X)
print(int(N))

with open('13.txt') as f:
    d = f.readlines()

N = 0
A = np.zeros((2,2), dtype=np.float64)
b = np.zeros(2, dtype=np.float64)
for i in range(len(d)):
    if i % 4 == 0:
        # A
        X_offset, Y_offset = d[i].split(',')
        X_offset = X_offset.split('+')[1].strip()
        Y_offset = Y_offset.split('+')[1].strip()
        A[0,0] = int(X_offset)
        A[1,0] = int(Y_offset)
    if i % 4 == 1:
        # B
        X_offset, Y_offset = d[i].split(',')
        X_offset = X_offset.split('+')[1].strip()
        Y_offset = Y_offset.split('+')[1].strip()
        A[0,1] = int(X_offset)
        A[1,1] = int(Y_offset)
    if i % 4 == 2:
        s_xy = d[i].split(':')[1].strip()
        s_x, s_y = s_xy.split(',')
        s_x = s_x.split('=')[1]
        s_y = s_y.split('=')[1]
        b[0] = int(s_x) + 10000000000000
        b[1] = int(s_y) + 10000000000000

        X = np.linalg.solve(A,b)
        X_int = np.round(X) 
        if np.allclose(b, A.dot(X_int), rtol=1e-18):
            if (np.all((X >= 0))):
                N += X[0]*3 + X[1]
print(int(N))
