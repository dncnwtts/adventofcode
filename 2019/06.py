import numpy as np

orbit_list = [
'COM)B',
'B)C',
'C)D',
'D)E',
'E)F',
'B)G',
'G)H',
'D)I',
'E)J',
'J)K',
'K)L']

orbit_dict = {}

for i in range(len(orbit_list)):
    A, B = orbit_list[i].split(')')
    orbit_dict[B] = A


# This can get recursive quickly. Dumb way first.
def count_orbits(odict, k):
    n = 0
    A = odict[k]
    if A in odict.keys():
        n += 1
        n += count_orbits(odict, A)
        return n
    else:
        n += 1
        return n


orbit_list = np.loadtxt('input06.txt', dtype=str)

orbit_dict = {}
for i in range(len(orbit_list)):
    A, B = orbit_list[i].split(')')
    orbit_dict[B] = A


n_orbits = 0
for key in orbit_dict.keys():
    n_orbits += count_orbits(orbit_dict, key)
print(n_orbits)


def return_orbits(odict, k):
    A = odict[k]
    if A in odict.keys():
        orb_out = return_orbits(odict, A)
        return orb_out + ',' + A
    else:
        return A

orb_you = return_orbits(orbit_dict, 'YOU')
orb_san = return_orbits(orbit_dict, 'SAN')

orb_you = orb_you.split(',')
orb_san = orb_san.split(',')


for i in range(1,min(len(orb_you), len(orb_san))):
    if orb_you[i] != orb_san[i]:
        print(len(orb_you)-i + len(orb_san)-i)
        break
