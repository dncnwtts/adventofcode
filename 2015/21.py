import numpy as np

def battle(boss, me):
    while True:
        boss['hp'] -= me['damage']   - boss['armor']
        if boss['hp'] <= 0:
            break
        me['hp']   -= boss['damage'] - me['armor']
        if me['hp'] <= 0:
            break
    if boss['hp'] <= 0:
        return True
    else:
        return False

weapons = [(8,4), (10,5), (25,6), (40, 7), (74,8)]
armors = [(13,1), (31,2), (53,3), (75,4), (102,5)]
rings = [(25,1,0), (50,2,0), (100,3,0), (20,0,1), (40,0,2), (80,0,3)]

def equip(me):
    gold = 0
    inds = np.arange(len(weapons))
    weapon = weapons[np.random.choice(inds)]
    a = np.random.random()
    inds = np.arange(len(armors))
    if (a > 0.5):
        armor = armors[np.random.choice(inds)]
    else:
        armor = (0,0)

    b = np.random.random()
    inds = np.arange(len(rings))
    if (b > 1/3) and (b < 2/3):
        ring = [rings[np.random.choice(inds)]]
    elif (b > 2/3):
        x = np.random.choice(inds,2, replace=False)
        ring = [rings[i] for i in x]
    else:
        ring = [(0,0,0)]

    gold += weapon[0]
    gold += armor[0]
    for i in range(len(ring)):
        gold += ring[i][0]

    me['armor'] = armor[1]
    me['damage'] = weapon[1]
    for i in range(len(ring)):
        me['armor'] += ring[i][2]
        me['damage'] += ring[i][1]

    return gold, me
me = {
        'hp':8,
        'damage':5,
        'armor':5
        }

boss = {
        'hp': 12,
        'damage':7,
        'armor':2
        }
print(battle(boss, me))

boss = {
        'hp': 104,
        'damage':8,
        'armor':1
        }
me = {
        'hp':100,
        'damage':5,
        'armor':5
        }
print(battle(boss, me))

# 110 is too high
min_gold = np.inf
for i in range(100000):
    me['hp'] = 100
    boss['hp'] = 104
    gold, me = equip(me)
    if battle(boss, me):
        if gold < min_gold:
            min_gold = gold
            print(min_gold, me)

max_gold = -np.inf

for i in range(10000):
    me['hp'] = 100
    boss['hp'] = 104
    gold, me = equip(me)
    if not battle(boss, me):
        if gold > max_gold:
            max_gold = gold
            print(max_gold, me)
