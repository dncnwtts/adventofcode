import numpy as np


key_l = {'A': 'rock',
         'B': 'paper',
         'C': 'scissors'}
key_r = {'X': 'rock',
         'Y': 'paper',
         'Z': 'scissors'}

scores = {'rock': 1,
          'paper':2,
          'scissors':3}

def compare_round(moves):
    l, r = moves
    if key_l[l] == key_r[r]:
        # tie
        return 3 + scores[key_r[r]]
    elif key_l[l] == 'rock' and key_r[r] == 'paper':
        return 6 + scores['paper']
    elif key_l[l] == 'rock' and key_r[r] == 'scissors':
        return 0 + scores['scissors']
    elif key_l[l] == 'paper' and key_r[r] == 'scissors':
        return 6 + scores['scissors']
    elif key_l[l] == 'paper' and key_r[r] == 'rock':
        return 0 + scores['rock']
    elif key_l[l] == 'scissors' and key_r[r] == 'paper':
        return 0 + scores['paper']
    elif key_l[l] == 'scissors' and key_r[r] == 'rock':
        return 6 + scores['rock']
    else:
        print(key_l[l], key_r[r])
        print(f'Weird input, {l} and {r}')
        return 0


guide = np.loadtxt('input02.txt', dtype=str)
n = 0
for g in guide:
    n += compare_round(g)
print(n)


key_r2 = {'X': 'lose',
         'Y': 'draw',
         'Z': 'win'}

convert = {'A':'X',
           'B':'Y',
           'C':'Z'}

def compare_round2(moves):
    l, r = moves
    outcome = key_r2[r]
    if outcome == 'draw':
        r = convert[l]
    elif outcome == 'win':
        if l == 'A':
            r = 'Y' #'paper'
        elif l == 'B':
            r = 'Z' #'scissors'
        elif l == 'C':
            r = 'X' #'rock'
        else:
            print('outcome does not make sense', l, outcome)
    elif outcome == 'lose':
        if l == 'A':
            r = 'Z' #'scissors'
        elif l == 'B':
            r = 'X' #'rock'
        elif l == 'C':
            r = 'Y' #'paper'
        else:
            print('outcome does not make sense', l, outcome)
    else:
        print('Something strange has happened')
    return compare_round([l,r])

n = 0
for g in guide:
    n += compare_round2(g)
print(n)
