max_vals = {'red':12, 'green': 13, 'blue':14}
max_vals['sum'] = sum(max_vals.values())
def check_draw(draw):
    cubes = draw.strip().split(',')
    tot_in_draw = 0
    for i in range(len(cubes)):
        c = cubes[i].strip()
        num, key = c.split(' ')
        tot_in_draw += int(num)
        if max_vals[key] < int(num):
            return True, 0
    return False, tot_in_draw

ans1 = 0
with open("02.txt", "r") as f:
    Lines = f.readlines()
    for l in Lines:
        game_no = int(l.split(':')[0][5:])
        draws = l.split(':')[1].split(';')
        ok = True
        for d in draws:
            invalid, tot_in_draw = check_draw(d)
            if invalid or (tot_in_draw > max_vals['sum']):
                ok = False
                break
        if ok:
            ans1 += game_no
print(ans1)

ans2 = 0
with open("02.txt", "r") as f:
    Lines = f.readlines()
    ans2 = 0
    for l in Lines:
        game_no = int(l.split(':')[0][5:])
        draws = l.split(':')[1].split(';')
        min_dict = {}
        for draw in draws:
            cubes = draw.strip().split(',')
            for i in range(len(cubes)):
                c = cubes[i].strip()
                num, key = c.split(' ')
                if key in min_dict.keys():
                    if min_dict[key] < int(num):
                        min_dict[key] = int(num)
                else:
                    min_dict[key] = int(num)
        power = 1
        for key in min_dict.keys():
            power *= min_dict[key]
        ans2 += power
print(ans2)
