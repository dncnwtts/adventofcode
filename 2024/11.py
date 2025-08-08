import numpy as np
from tqdm import tqdm
import functools

def calc(stone):
    if stone == 0:
        new_stones = [1, None]
    elif len(str(stone)) % 2 == 0:
        stone_str = str(stone)
        new_stones = [int(stone_str[:len(stone_str)//2]), int(stone_str[len(stone_str)//2:])]
    else:
        new_stones = [stone*2024, None]
    return new_stones

@functools.cache
def count_blink(stone, depth):
    left_stone, right_stone = calc(stone)
    if depth == 1:
        if right_stone is None:
            return 1
        else:
            return 2
    else:
        output = count_blink(left_stone, depth - 1)

        if right_stone is not None:
            output += count_blink(right_stone, depth - 1)
    return output

stones = [890,0,1,935698,68001,3441397,7221,27]



n = 0
for s in stones:
    n += count_blink(s, 75)
print(n)
