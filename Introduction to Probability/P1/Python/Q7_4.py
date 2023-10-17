import Snow_3g
import math
import matplotlib.pyplot as plt
import random


def rnd():
    r = random.randint(1, 1001)
    temp = out[r: r + 10]
    x = int(temp, 2)
    if x >= 1000:
        return x / 10000
    else:
        return x / 1000


out = Snow_3g.out
# λ = 2
# n = 200
# p = 0.02
# p = p * 1000
# p = math.floor(p)
# k = 0
index = 0
values2 = []
x2 = []
y2 = []
x3 = []
y3 = []
x5 = []
y5 = []
lam = 2
l = math.exp(-lam)
k = 0
p = 1
for i in range(0, 10000):
    k = 0
    p = 1
    while 1:
        k = k + 1
        u = rnd()
        p = p * u
        if p <= l:
            break
    values2.append(k - 1)
# print(values2)
for i in range(0, 15):
    x2.append(i)
    y2.append(0)
for i in range(0, len(values2)):
    y2[values2[i]] = y2[values2[i]] + 1
# λ = 3

k = 0
index = 0
values3 = []
lam = 3
l = math.exp(-lam)
k = 0
p = 1
for i in range(0, 10000):
    k = 0
    p = 1
    while 1:
        k = k + 1
        u = rnd()
        p = p * u
        if p <= l:
            break
    values3.append(k - 1)
    # print(values3)
for i in range(0, 25):
    x3.append(i)
    y3.append(0)
for i in range(0, len(values3)):
    y3[values3[i]] = y3[values3[i]] + 1
# λ = 5

k = 0
index = 0
values5 = []
lam = 5
l = math.exp(-lam)
k = 0
p = 1
for i in range(0, 10000):
    k = 0
    p = 1
    while 1:
        k = k + 1
        u = rnd()
        p = p * u
        if p <= l:
            break
    values5.append(k - 1)
# print(values5)
for i in range(0, 50):
    x5.append(i)
    y5.append(0)
for i in range(0, len(values5)):
    y5[values5[i]] = y5[values5[i]] + 1
for i in range(0, len(y2)):
    y2[i] = y2[i] / 10000
for i in range(0, len(y3)):
    y3[i] = y3[i] / 10000
for i in range(0, len(y5)):
    y5[i] = y5[i] / 10000
plt.title("Poisson Distribution")
plt.plot(x2, y2, label="λ = 2")
plt.plot(x3, y3, label="λ = 3")
plt.plot(x5, y5, label="λ = 5")
plt.legend()
plt.show()
