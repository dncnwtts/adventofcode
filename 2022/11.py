import operator

class Monkey():
    def __init__(self, items, op, val, mod, true, false):
        self.items = items
        self.mod = mod
        self.true = true
        self.false = false
        self.op = op
        self.val = val

    def func(self, old):
        if self.val == 'old':
            new = self.op(old, old)
        else:
            new = self.op(old, self.val)
        return new

    def test(self):
        if self.items[0] % self.mod == 0:
            new = self.true
        else:
            new = self.false
        monkeys[new].items.append(self.items[0])
        self.items.pop(0)


monkeys = []

f = open('input11.txt')
Lines = f.readlines()
for line in Lines:
    if 'Monkey' in line:
        #"New class"
        continue
    elif 'Starting items' in line:
        x = line.split('Starting items:')[1]
        xsplit = x.split(',')
        l = []
        for i in range(len(xsplit)):
            l.append(int(xsplit[i]))
    elif 'divisible by' in line:
        mod = int(line.split('divisible by')[-1])
    elif 'true' in line:
        true = int(line.split('monkey')[-1])
    elif 'false' in line:
        false = int(line.split('monkey')[-1])
    elif 'Operation' in line:
        operation = line.split('new = old')[-1].strip()
        if '*' in operation:
            op = operator.mul
        elif '+' in operation:
            op = operator.add

        if 'old' in operation:
            val = 'old'
        else:
            val = int(operation[2:])
    else:
        monkeys.append(Monkey(l, op, val, mod, true, false))


inspections = [0]*len(monkeys)
for i in range(20):
    for j, m in enumerate(monkeys):
        while len(m.items) != 0:
            m.items[0] = m.func(m.items[0])
            m.items[0] = m.items[0]//3
            m.test()
            inspections[j] += 1
    
inspections.sort()

print(inspections[-1]*inspections[-2])

monkeys = []
f = open('input11.txt')
Lines = f.readlines()
for line in Lines:
    if 'Monkey' in line:
        #"New class"
        continue
    elif 'Starting items' in line:
        x = line.split('Starting items:')[1]
        xsplit = x.split(',')
        l = []
        for i in range(len(xsplit)):
            l.append(int(xsplit[i]))
    elif 'divisible by' in line:
        mod = int(line.split('divisible by')[-1])
    elif 'true' in line:
        true = int(line.split('monkey')[-1])
    elif 'false' in line:
        false = int(line.split('monkey')[-1])
    elif 'Operation' in line:
        operation = line.split('new = old')[-1].strip()
        if '*' in operation:
            op = operator.mul
        elif '+' in operation:
            op = operator.add

        if 'old' in operation:
            val = 'old'
        else:
            val = int(operation[2:])
    else:
        monkeys.append(Monkey(l, op, val, mod, true, false))
inspections = [0]*len(monkeys)

mod_all = 1
for m in monkeys:
    mod_all *= m.mod
for i in range(10000):
    for j, m in enumerate(monkeys):
        #print(m.items)
        while len(m.items) != 0:
            m.items[0] = m.func(m.items[0])
            m.items[0] = (m.items[0] % mod_all)
            m.test()
            inspections[j] += 1
    if i in [0, 19, 999, 1999, 2999, 3999, 4999, 5999, 6999, 7999, 8999, 9999]:
        bla = inspections.copy()
        bla.sort()
        print(i, inspections, bla[-1]*bla[-2])
    
inspections.sort()

print(inspections[-1]*inspections[-2])
