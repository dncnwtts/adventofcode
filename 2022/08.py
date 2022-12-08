import numpy as np
d = np.loadtxt('input08.txt', dtype=str)
n = len(d)
heights = np.zeros((n,n), dtype=int)
for i in range(len(d)):
    for j in range(len(d)):
        heights[i,j] = d[i][j]


visible = np.zeros((n,n), dtype=bool)


for i in range(len(heights)):
    for j in range(len(heights)):
        h0 = heights[i,j]
        h_above = heights[:i,j]
        h_below = heights[i+1:,j]
        h_left = heights[i,:j]
        h_right = heights[i,j+1:]
        if np.all(h0 > h_above) or np.all(h0 > h_below) or np.all(h0 > h_left) or np.all(h0 > h_right):
            visible[i,j] = True
        elif i == 0 or j == 0 or i == n-1 or j == n-1:
            visible[i,j] = True
print(visible.sum())


scores = np.ones((n,n), dtype=int)
for i in range(len(heights)):
    for j in range(len(heights)):
        if i == 0 or j == 0 or i == n-1 or j == n-1:
            scores[i,j] = 0
            continue
        h0 = heights[i,j]
        h_above = (h0 > heights[:i,j])[::-1]
        h_below = (h0 > heights[i+1:,j])
        h_left =  (h0 > heights[i,:j])[::-1]
        h_right = (h0 > heights[i,j+1:])
        for k in range(len(h_above)):
            a = k + 1
            if not h_above[k]:
                break
        for k in range(len(h_below)):
            b = k + 1
            if not h_below[k]:
                break
        for k in range(len(h_left)):
            c = k + 1
            if not h_left[k]:
                break
        if k == len(h_left)-1: scores[i,j] *= len(h_left)
        for k in range(len(h_right)):
            d = k + 1
            if not h_right[k]:
                break
        scores[i,j] = a*b*c*d

print(scores.max())
