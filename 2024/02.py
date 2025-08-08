import numpy as np

num = 0
with open('02.txt', 'r') as f:
    data = f.readlines()

def check_safe(report):
    diff = np.diff(report)
    sgn  = np.sign(diff)
    samesign = np.all(sgn == sgn[0])
    rate = (abs(diff).min() >= 1) & (abs(diff).max() <= 3)
    if (samesign & rate):
        return True
    else:
        return False

for d in data:
    di = np.array(d.split()).astype(int)
    if check_safe(di):
        num += 1
print(num)


def dampen(report):
    for i in range(len(report)):
        report2 = np.concatenate((report[:i], report[i+1:]))
        if check_safe(report2):
            return True
    return False


num = 0
for d in data:
    di = np.array(d.split()).astype(int)
    if check_safe(di):
        num += 1
    else:
        if dampen(di):
           num += 1
print(num)
