import numpy as np

turns = np.array([7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
turns = np.array([18,99,39,89,0,40,52,72,61,77,69,51,30,83,20,65,93,88,29,22,14,82,53,41,76,79,46,78,56,57,24,36,38,11,50,1,19,26,70,4,54,3,84,33,15,21,9,58,64,85,10,66,17,43,31,27,2,5,95,96,16,97,12,34,74,67,86,23,49,8,59,45,68,91,25,48,13,28,81,94,92,42,7,37,75,32,6,60,63,35,62,98,90,47,87,73,44,71,55,80])


def check(board):
    for i in range(len(board)):
        if sum(~np.isfinite(board[i])) == 5:
            return True
        if sum(~np.isfinite(board[:,i])) == 5:
            return True
    return False

data = np.loadtxt('data/04_ex.txt')
data = np.loadtxt('data/04.txt')
num_boards = len(data)//5
min_num = np.inf
for j in range(num_boards):
    board = data[5*j:5*(j+1)]
    for i in range(len(turns)):
        if i > min_num:
            break
        board[board == turns[i]] = np.inf
        if check(board):
            answer = int(sum(board[np.isfinite(board)]*turns[i]))
            min_num = i
            break
print(answer)

data = np.loadtxt('data/04_ex.txt')
data = np.loadtxt('data/04.txt')

max_num = -np.inf
for j in range(num_boards):
    board = data[5*j:5*(j+1)]
    for i in range(len(turns)):
        board[board == turns[i]] = np.inf
        if check(board):
            if i > max_num:
                max_num = i
                answer = int(sum(board[np.isfinite(board)]*turns[i]))
            break
print(answer)
