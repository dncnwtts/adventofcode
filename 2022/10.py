def draw_sprite(X):
    L = 40
    CRT = ''
    for i in range(L):
        if abs(X - i) > 1:
            CRT = CRT + '.'
        else:
            CRT = CRT + '#'
    return CRT
X = 1
cycle = 0
tot_strength = 0


f = open('input10.txt')

draw_sprite(X)
CRT = ''
Lines = f.readlines()
for line in Lines:
    if 'noop' in line:
        cycle += 1
        CRT += draw_sprite(X)[(cycle-1) % 40]
        if cycle % 40 == 0:
            print(CRT)
            CRT = ''
        signal_strength = cycle * X
        pix = (cycle - 20) % 40
        if pix == 0:
            tot_strength += signal_strength
    else:
        cycle += 1
        CRT += draw_sprite(X)[(cycle-1) % 40]
        if cycle % 40 == 0:
            print(CRT)
            CRT = ''
        pix = (cycle - 20) % 40
        signal_strength = cycle * X
        if pix == 0:
            tot_strength += signal_strength
        cycle += 1
        CRT += draw_sprite(X)[(cycle-1) % 40]
        if cycle % 40 == 0:
            print(CRT)
            CRT = ''
        signal_strength = cycle * X
        pix = (cycle - 20) % 40
        if pix == 0:
            tot_strength += signal_strength
        X += int(line[4:])
print(tot_strength)
