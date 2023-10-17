import Snow_3g
import matplotlib.pyplot as plt
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


lam = 5
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
    if k - 1 >= 3:
        values.append(k - 1)
maxx = -100
x1 = []
for i in range(0, 50):
    x1.append(i)
y1 = []
for i in range(0, 50):
    y1.append(0)
length = len(values)
for i in range(0, length):
    y1[values[i]] = y1[values[i]] + 1
for i in range(0, len(y1)):
    y1[i] = y1[i] / length
plt.title("probability mass function of X")

plt.bar(x1, y1, width=0.5)
plt.show()
