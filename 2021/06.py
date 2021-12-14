



import numpy as np

# part 2

class LanternFish:
    def __init__(self, init=8):
        self.timer = init

    def iterate(self, all_fish):
        if self.timer == 0:
            self.timer = 6
            all_fish.append(LanternFish())
            return all_fish
        else:
            self.timer -= 1
            return all_fish


init_timers = [3,4,3,1,2]

init_timers = [4,1,1,4,1,2,1,4,1,3,4,4,1,5,5,1,3,1,1,1,4,4,3,1,5,3,1,2,5,1,1,5,1,1,4,1,1,1,1,2,1,5,3,4,4,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,5,1,1,1,4,1,2,3,5,1,2,2,4,1,4,4,4,1,2,5,1,2,1,1,1,1,1,1,4,1,1,4,3,4,2,1,3,1,1,1,3,5,5,4,3,4,1,5,1,1,1,2,2,1,3,1,2,4,1,1,3,3,1,3,3,1,1,3,1,5,1,1,3,1,1,1,5,4,1,1,1,1,4,1,1,3,5,4,3,1,1,5,4,1,1,2,5,4,2,1,4,1,1,1,1,3,1,1,1,1,4,1,1,1,1,2,4,1,1,1,1,3,1,1,5,1,1,1,1,1,1,4,2,1,3,1,1,1,2,4,2,3,1,4,1,2,1,4,2,1,4,4,1,5,1,1,4,4,1,2,2,1,1,1,1,1,1,1,1,1,1,1,4,5,4,1,3,1,3,1,1,1,5,3,5,5,2,2,1,4,1,4,2,1,4,1,2,1,1,2,1,1,5,4,2,1,1,1,2,4,1,1,1,1,2,1,1,5,1,1,2,2,5,1,1,1,1,1,2,4,2,3,1,2,1,5,4,5,1,4]

vals, nums = np.unique(init_timers, return_counts=True)

all_vals = {}
for j in range(9):
    all_vals[j] = 0
for i in range(len(vals)):
    all_vals[vals[i]] += nums[i]

for i in range(256):
    new_vals = {}
    for key in range(9):
        new_vals[key] = 0
    for key in range(9):
        if (key != 0) and (key != 7):
            new_vals[key-1] = all_vals[key]
        elif (key == 0):
            new_vals[8] = all_vals[0]
            new_vals[6] = all_vals[0]
        elif (key == 7):
            new_vals[6] += all_vals[7]
    all_vals = new_vals.copy()
v = 0
for key in all_vals.keys():
    v += all_vals[key]
print(v)
