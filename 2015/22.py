import numpy as np

def player_turn(player, boss, spell, spells):
    apply_effects(player, boss, spells)
    if 'damage' in spell.keys():
        boss['hp'] -= spell['damage']
    if 'heal' in spell.keys():
        player['hp'] += spell['heal']
    if 'effect0' in spell.keys():
        spell['effect'] = spell['effect0']
    player['mana'] -= spell['cost']
    return


def boss_turn(player, boss, spells):
    apply_effects(player, boss, spells)
    if boss['hp'] <= 0:
        return
    player['hp'] -= max(boss['damage'] - player['armor'], 1)
    return

def apply_effects(player, boss, spells):
    if spells[2]['effect'] == 0:
        player['armor'] = 0
    if spells[2]['effect'] > 0:
        player['armor'] = 7
        spells[2]['effect'] -= 1
    if spells[3]['effect'] > 0:
        boss['hp'] -= 3
        spells[3]['effect'] -= 1
    if spells[4]['effect'] > 0:
        player['mana'] += 101
        spells[4]['effect'] -= 1

player = {'hp': 10,
        'mana': 250,
        'armor':0}

boss = {'hp': 13,
        'damage': 8}

spells = [
        {'cost':53, # magic missile
         'damage':4},
        {'cost': 73, # drain
         'damage':2,
         'heal':2},
        {'cost':113, # shield
         'effect':0,
         'effect0':6,
         'armor': 7},
        {'cost':173, # poison
         'effect':0,
         'effect0':6,
         'poison':3},
        {'cost':229, # recharge
        'effect':0,
        'effect0':5,
        'newmana':101}]


for spell in spells:
    if 'effect' in spell.keys():
        spell['effect'] = 0

player = {'hp': 10,
        'mana': 250,
        'armor':0}

boss = {'hp': 14,
        'damage': 8}

print('playerturn')
print(player)
print(boss)

player_turn(player, boss, spells[4], spells)

print('bossturn')
print(player)
print(boss)

boss_turn(player, boss, spells)

print('playerturn')
print(player)
print(boss)

player_turn(player, boss, spells[2], spells)

print('bossturnturn')
print(player)
print(boss)

boss_turn(player, boss, spells)
print(player)
print(boss)

player_turn(player, boss, spells[1], spells)
print(player)
print(boss)

boss_turn(player, boss, spells)
print(player)
print(boss)

player_turn(player, boss, spells[3], spells)
print(player)
print(boss)

boss_turn(player, boss, spells)
print(player)
print(boss)

player_turn(player, boss, spells[0], spells)

print(player)
print(boss)
boss_turn(player, boss, spells)

print(player)
print(boss)


def sim_battle(player, boss, spells, min_mana):
    mana_spent = 0
    player = {'hp': 50,
            'mana': 500,
            'armor':0}
    
    boss = {'hp': 51,
            'damage': 9}

    while True:
        if min_mana < mana_spent:
            return False, mana_spent
        if player['mana'] < 53:
            return False, mana_spent
        spell = np.random.choice(spells)
        if 'effect' in spell.keys():
            if spell['effect'] > 0:
                while ('effect' in spell.keys() and spell['effect'] > 0):
                    spell = np.random.choice(spells)
        player_turn(player, boss, spell, spells)

        mana_spent += spell['cost']
        
        if boss['hp'] <= 0:
            return True, mana_spent

        boss_turn(player, boss, spells)
        if boss['hp'] <= 0:
            return True, mana_spent
        if player['hp'] <= 0:
            return False, mana_spent

# 558 is too low
# 900 appears to be the answer, but I am getting it wrong for some reason
min_mana = np.inf
for i in range(100000):
    res, mana_spent = sim_battle(player, boss, spells, min_mana)
    if res and (min_mana > mana_spent):
        min_mana = mana_spent
        print(min_mana)
