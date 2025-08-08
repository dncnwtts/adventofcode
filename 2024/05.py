import numpy as np

d1 = np.loadtxt('05a.txt', dtype=int, delimiter='|')

with open('05b.txt') as f:
    d = f.readlines()

d2 = []
d3 = []
for i in range(len(d)):
    s = d[i].strip().split(',')
    t = d[i].strip().split(',')
    s = [int(si) for si in s]
    t = [int(si) for si in t]
    d2.append(s)
    d3.append(t)

rules = {}
reverse = {}

for i in range(len(d1)):
    if d1[i][0] in rules.keys():
        rules[d1[i][0]].append(d1[i][1])
        if d1[i][1] in reverse.keys():
            reverse[d1[i][1]].append(d1[i][0])
        else:
            reverse[d1[i][1]] = [d1[i][0]]
    else:
        rules[d1[i][0]] = [d1[i][1]]
        if d1[i][1] in reverse.keys():
            reverse[d1[i][1]].append(d1[i][0])
        else:
            reverse[d1[i][1]] = [d1[i][0]]



# Check if command follows the rules
n = 0
badones = []
for i in range(len(d2)):
    ok = True
    for j in range(len(d2[i])):
        if ok:
            if d2[i][j] in rules.keys():
                for k in rules[d2[i][j]]:
                    inds = np.where(d2[i] == k)
                    if len(inds[0]) == 0:
                        pass
                    else:
                        if (j > inds[0][0]):
                            ok = False
                            badones.append(i)
    if ok:
        n += d2[i][len(d2[i])//2]
    
print(n)
print()
for i in badones:
    for j in range(len(d2[i])):
        if d3[i][j] in rules.keys():
            ind_list = []
            for k in rules[d3[i][j]]:
                inds = np.where(d3[i] == k)
                if len(inds[0]) > 0:
                    ind_list.append(inds[0][0])
            if len(ind_list) > 0:
                if j > min(ind_list):
                    d3[i] = d3[i][:min(ind_list)] + [d3[i][j]] + d3[i][min(ind_list):j] + d3[i][j+1:]

badones = np.unique(badones)
m = 0
for i in badones:
    m += d3[i][len(d3[i])//2]
print(m)

# 6790 is too large, something is wrong
# 5078 is also too large.
