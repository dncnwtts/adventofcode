tot = 0
with open('04.txt') as f:
    Lines = f.readlines()
    N = len(Lines)
    for i in range(len(Lines)):
        l = Lines[i].strip()
        winning, have = l.split(':')[1].split('|')
        winning = winning.split()
        have = have.split()
        p = -1
        for j in range(len(winning)):
            if winning[j] in have:
                p += 1
        if p > -1:
            tot += 2**p
print(tot)

with open('04.txt') as f:
    Lines = f.readlines()
    N = len(Lines)
    mult_facts = {}
    for i in range(N):
        mult_facts[i+1] = 1
    for i in range(len(Lines)):
        l = Lines[i].strip()
        card_no, whave = l.split(':')
        card_no = card_no[5:]
        winning, have = whave.split('|')
        winning = winning.split()
        have = have.split()
        p = 0
        for j in range(len(winning)):
            if winning[j] in have:
                p += 1
        for i in range(1,p+1):
            mult_facts[int(card_no) + i] += mult_facts[int(card_no)]
v = 0
for vals in mult_facts.values():
    v += vals

print(v)
