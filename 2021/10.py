import numpy as np


lefts  = r'<{[('
rights = r'>}])'

matches = {}
for i in range(len(lefts)):
    matches[lefts[i]] = rights[i]
    matches[rights[i]] = lefts[i]
print(matches)

line = r'{([(<{}[<>[]}>{[]{[(<()>'
line = r'{()()()}'

'''
def is_corrupted(line):
    if line[0] in lefts:
        start = line[0]
        if matches[start] == line[1]:
            if len(line) == 2:
                return False
            else:
                print(line[2:])
                return is_corrupted(line[2:])
        else:
            return is_corrupted(line[1:])
    else:
        return True
'''

def is_valid(line):
    if line[0] in lefts:
        if matches[line[0]] == line[1]:
            if len(line) == 2:
                return True
            else:
                return is_valid(line[2:])
        else:
            return is_valid(line[1:])
    else:
        return False


print(is_valid(line))
