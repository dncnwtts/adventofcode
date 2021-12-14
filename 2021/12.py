import numpy as np


paths = [
('start','A'),
('start','b'),
('A','c'),
('A','b'),
('b','d'),
('A','end'),
('b','end')]

paths = [
('dc','end'),
('HN','start'),
('start','kj'),
('dc','start'),
('dc','HN'),
('LN','dc'),
('HN','end'),
('kj','sa'),
('kj','HN'),
('kj','dc')]
inds = np.arange(len(paths))


ps = []
for i in range(100000):
    hits = {}
    for i in range(len(paths)):
        hits[paths[i][0]] = 0
        hits[paths[i][1]] = 0
    
    p = []
    while True:
        p1 = paths[np.random.choice(inds)]
        if p1[0] == 'start':
            hits[p1[0]] += 1
            hits[p1[1]] += 1
            p.append(p1)
            break
        elif p1[1] == 'start':
            hits[p1[0]] += 1
            hits[p1[1]] += 1
            p.append((p1[1], p1[0]))
            break
    while True:
        p1 = paths[np.random.choice(inds)]
        if (p[-1][1] == p1[0]) and ((p1[1].islower() and hits[p1[1]] < 1) or (p1[1].isupper())):
            p.append(p1)
        elif (p[-1][1] == p1[1]) and ((p1[0].islower() and hits[p1[0]] < 1) or (p1[0].isupper())):
            p.append((p1[1],p1[0]))
        else:
            success = False
            break
    
        hits[p[-1][1]] += 1

    
        if p[-1][1] == 'end':
            success = True
            break
    if success:
        s = 'start,'
        for i in range(len(p)):
            s += p[i][1] + ','
        ps.append(s[:-1])

print(len(set(ps)))
print(set(ps))
