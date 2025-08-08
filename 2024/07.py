import numpy as np
from tqdm import tqdm

with open('07.txt') as f:
    d = f.readlines()

import itertools

ops = [np.add, np.multiply]
total = 0
d_okay = np.zeros(len(d))
for i in tqdm(range(len(d))):
    d[i] = d[i].strip()
    s, terms = d[i].split(': ')
    s = int(s)
    terms = terms.split(' ')
    terms = [int(t) for t in terms]
    perms = itertools.product(ops, repeat=len(terms)-1)
    for perm in perms:
        s_bla = terms[0]
        for j in range(len(perm)):
            s_bla = perm[j](s_bla, terms[j+1])
        if s_bla == s:
            d_okay[i] = True
            total += s_bla
            break
print(total)


ops = [np.add, np.multiply, '||']
for i in tqdm(range(len(d))):
    if d_okay[i]:
        continue
    d[i] = d[i].strip()
    s, terms = d[i].split(': ')
    s = int(s)
    terms = terms.split(' ')
    terms = [int(t) for t in terms]
    perms = itertools.product(ops, repeat=len(terms)-1)
    for perm in perms:
        if d_okay[i]:
            continue
        for j in range(len(terms)-1):
            if d_okay[i]:
                continue
            s_bla = terms[0]
            for k in range(len(perm)):
                if perm[k] == '||':
                    s_bla = int(str(s_bla) + str(terms[k+1]))
                else:
                    s_bla = perm[k](s_bla, terms[k+1])
            if s_bla == s:
                d_okay[i] = True
                total += s_bla
print(total)
