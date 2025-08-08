import numpy as np

with open('03.txt') as f:
    data = f.readlines()

num = 0
for s in data:
    for si in s.split('mul('):
        b = si.split(',')[0]
        if b.isdigit():
            c = si.split(',')[1].split(')')[0]
            if c.isdigit():
                # check if mul(b,c) is in the string
                if f'mul({int(b)},{int(c)})' in s:
                    num += int(b)*int(c)
print(num)

# We actually need to look for "do()" and "don't()" instructions as well.


execute = True
num = 0
for s in data:
    if execute:
        do_inds = [0]
        dont_inds = [-1]
    else:
        do_inds = [-1]
        dont_inds = [0]
    i0 = 0
    while True:
        ind = s.find("don't()", i0)
        if ind != -1:
            dont_inds.append(ind)
            i0 = ind + 7
        else:
            break
    i0 = 0
    while True:
        ind = s.find("do()", i0)
        if ind != -1:
            do_inds.append(ind)
            i0 = ind + 4
        else:
            break
    i0 = 0
    do_inds = np.array(do_inds)
    dont_inds = np.array(dont_inds)
    while True:
        ind = s.find("mul(", i0)
        if ind != -1:
            si = s[ind+4:]
            diff_do = do_inds[do_inds < ind]
            diff_dont = dont_inds[dont_inds < ind]
            if (diff_do[-1] > diff_dont[-1]):
                execute = True
            else:
                execute = False
            if execute:
                b = si.split(',')[0]
                if b.isdigit():
                    c = si.split(',')[1].split(')')[0]
                    if c.isdigit():
                        # check if mul(b,c) is in the string
                        if f'mul({int(b)},{int(c)})' in s:
                            num += int(b)*int(c)
            i0 = ind + 4
        else:
            break

print(num)
