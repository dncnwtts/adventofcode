import numpy as np

class FileSyst():
    def __init__(self, name, is_dir, parent=None, size=0, depth=0):
        self.name   = name
        self.parent = parent
        self.is_dir = is_dir
        self.size   = size
        if is_dir:
            self.children = []
        return
    def set_size(self, size):
        self.size   = size
    def add_child(self, name, is_dir, size=0, depth=0):
        c = FileSyst(name, is_dir, self, size, depth)
        self.children.append(c)
    def get_subdir_size(self):
        for child in self.children:
            if child.is_dir:
                self.size += child.get_subdir_size()
            else:
                self.size += child.size
        return self.size


def traverse_tree(tree):
    size = 0
    for c in tree.children:
        if c.is_dir:
            if c.size <= 100000:
                size += c.size
            size += traverse_tree(c)
    return size


f = open('input07_ex.txt')
f = open('input07_ex.txt')
Lines = f.readlines()
tree = FileSyst('/', True)
base = tree
for line in Lines:
    if '..' in line:
        tree = tree.parent
    elif 'cd' in line:
        current_dir_name = line[line.index('cd')+2:].strip()
        for c in tree.children:
            if c.name == current_dir_name:
                tree = c
    elif ' ls' in line:
        continue
    elif 'dir' in line:
        directory_name = line[line.index('dir')+3:].strip()
        tree.add_child(directory_name, True)
    else:
        num, item = line.split()
        tree.add_child(item, False, size=int(num))

base.get_subdir_size()
tot_size = traverse_tree(base)
print(tot_size)
