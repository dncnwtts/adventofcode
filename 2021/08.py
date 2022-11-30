import numpy as np

data = np.loadtxt('data/08_ex.txt', dtype=str)
data = np.loadtxt('data/08.txt', dtype=str)
data = np.array([['acedgfb','cdfbe', 'gcdfa', 'fbcad', 'dab', 'cefabd', 'cdfgeb', 'eafb', 'cagedb', 'ab', '|', 'cdfeb', 'fcadb', 'cdfeb', 'cdbaf']])

# The unique display lengths
back = {2: 1, 4: 4, 3: 7, 7: 8}
# the unique lengths of the displays
lens = {1: 2, 4:4, 7:3, 8:7}

ordered_encodings = {
        0: 'abcefg',
        1: 'cf',
        2: 'acdeg',
        3: 'acdfg',
        4: 'bcdf',
        5: 'abdfg',
        6: 'abdefg',
        7: 'acf',
        8: 'abcdefg',
        9: 'abcdfg'}


acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |

# len(1) == 2, len(2) == 4, len(7) == 3, len(8) == 7
disordered_encodings = {
        0: 'acedgfb',  # must be 8
        1: 'cdfbe',    # must b 9, and c is g.
        2: 'gcdfa',
        3: 'fbcad',
        4: 'dab',      # must be 7, d must be a
        5: 'cefabd',
        6: 'cdfgeb',
        7: 'eafb',     # must be 4, ef is bd or db
        8: 'cagedb',
        9: 'ab'        # must be 1, ab is cf or fc
        }


# 9 has abcdfg, we know that d is a, and 4 overlaps with everything except g
# So is there anything that aligns almost completely with 4 + (a->d), except for one?? 
# Or, 9 is eafb+d plus something else.

intersections = {}


for i in range(10):
    str1 = ordered_encodings[i]
    for j in range(i+1, 10):
        if j == i:
            continue
        str2 = ordered_encodings[j]
        l = len(set(str1).intersection(str2))
        if i < j:
            intersections[(i,j)] = l
        else:
            intersections[(j,i)] = l
print(intersections)


# I think an important thing to figure out is how many letters each display has in common

n = 0
for entry in data:
    split = np.where(entry == '|')[0][0]
    ins, outs = entry[:split], entry[split+1:]
    for out in outs:
        if len(out) in lens.values():
            n += 1

print(n)
# the length of each display
#lens = {0: 6, 1: 2, 3: 5, 4: 4, 5: 5, 6: 6, 7: 3, 8: 7, 9:6}



for entry in data:
    temp_intersections = {}
    split = np.where(entry == '|')[0][0]
    ins, outs = entry[:split], entry[split+1:]
    vals = np.concatenate((ins, outs))
    vals = ins
    for in_ in ins:
        if len(in_) in lens.values():
            print(in_, back[len(in_)])
    for i in range(len(vals)):
        str1 = vals[i]
        for j in range(i+1, len(vals)):
            str2 = vals[j]
            if (len(str1) not in lens.values()) or (len(str2) not in lens.values()):
                continue
            l = len(set(str1).intersection(str2))
            if l == 4:
                print(str1, str2, ordered_encodings[4], ordered_encodings[8])
            if l == 3:
                print(str1, str2, ordered_encodings[7], ordered_encodings[8])
            temp_intersections[(i,j)] = l
            #temp_intersections[(j,i)] = l

print(intersections)
print(temp_intersections)
