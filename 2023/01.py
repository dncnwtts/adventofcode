import numpy as np

def check_for_num(s):
    nums = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    for i in range(len(nums)):
        if s[:len(nums[i])] == nums[i]:
            return i+1, len(nums[i])
    else:
        return 0, 0

with open("01.txt", "r") as f:
    Lines = f.readlines()
    tot = 0
    for l in Lines:
        i = 0
        v = 0
        last = 0
        for c in l:
            if c.isdigit():
                if i == 0:
                    v += int(c)*10
                    i += 1
                    last = int(c)
                else:
                    last = int(c)
                    i += 1
        v += last
        tot += v
print(tot)

with open("01.txt", "r") as f:
    Lines = f.readlines()
    tot = 0
    for l in Lines:
        i = 0
        v = 0
        last = 0
        check_for_num(l)
        char_ind = 0
        j = 0
        ind = 0
        while j < len(l):
            if l[j:j+1].isdigit():
                num = int(l[j:j+1])
                last = num
                j += 1
            else:
                num, length = check_for_num(l[j:])
                if length != 0:
                    last = num
                j += 1
            if (ind == 0) & (num != 0):
                v += num*10
                ind += 1
                last = num
        tot += v + last
print(tot)
