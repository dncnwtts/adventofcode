import numpy as np
minval = 248345
maxval = 746315

def crit1(digits):
    for i in range(len(digits)-1):
        if digits[i] == digits[i+1]:
            return True
    return False

def crit2(digits):
    for i in range(len(digits)-1):
        if digits[i] > digits[i+1]:
            return False
    return True

def crit3(digits):
    for i in range(len(digits)-1):
        if digits[i] == digits[i+1]:
            if (i >0) and (i < len(digits)-2):
                if digits[i] != digits[i-1] and digits[i] != digits[i+2]:
                    return True
            if i == 0:
                if digits[i] != digits[i+2]:
                    return True
            if i == (len(digits) - 2):
                if digits[i] != digits[i-1]:
                    return True
    return False

def is_valid(password):
    n_max = int(np.ceil(np.log10(password)))
    digits = np.zeros(n_max)
    for i in range(n_max):
        digits[i] = password//(10**(n_max-i-1))
        password -= digits[i]*10**(n_max-i-1)
    if crit1(digits) & crit2(digits):
        return True
    else:
        return False

print(is_valid(111111))
print(is_valid(223450))


n_valid = 0
from tqdm import tqdm
for n in tqdm(range(minval, maxval+1)):
    if is_valid(n):
        n_valid += 1
print(n_valid)

def is_valid2(password):
    n_max = int(np.ceil(np.log10(password)))
    digits = np.zeros(n_max)
    for i in range(n_max):
        digits[i] = password//(10**(n_max-i-1))
        password -= digits[i]*10**(n_max-i-1)
    if crit2(digits) & crit3(digits):
        return True
    elif crit2(digits) & (not crit3(digits)):
        return False
    else:
        return False

n_valid = 0
for n in tqdm(range(minval, maxval+1)):
    if is_valid2(n):
        n_valid += 1
print(n_valid)
