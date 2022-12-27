X = 1
cycle = 0
tot_strength = 0
f = open('input10.txt')
Lines = f.readlines()
for line in Lines:
    if 'noop' in line:
        cycle += 1
        signal_strength = cycle * X
        if (cycle - 20) % 40 == 0:
            tot_strength += signal_strength
    else:
        cycle += 1
        signal_strength = cycle * X
        if (cycle - 20) % 40 == 0:
            tot_strength += signal_strength
        cycle += 1
        signal_strength = cycle * X
        if (cycle - 20) % 40 == 0:
            tot_strength += signal_strength
        X += int(line[4:])
print(tot_strength)
