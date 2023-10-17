import Snow_3g
import math
import random

out = Snow_3g.out


def rnd():
    r = random.randint(1, 1001)
    temp = out[r: r + 10]
    x = int(temp, 2)
    if x >= 1000:
        return x / 10000
    else:
        return x / 1000


lam = int(input("Enter lambda\n"))
l = math.exp(-lam)
k = 0
p = 1
values = []
for i in range(0, 10000):
    k = 0
    p = 1
    while 1:
        k = k + 1
        u = rnd()
        p = p * u
        if p <= l:
            break
    values.append(k - 1)
print(values)
