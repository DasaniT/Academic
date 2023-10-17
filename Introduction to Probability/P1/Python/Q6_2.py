import Snow_3g
import math
import matplotlib.pyplot as plt
import numpy as np

out = Snow_3g.out
p = 0.2
n = 100
uniform = 50
p = p * 1000
p = math.floor(p)
k = 0
z = []
f = []
index = 0
first = []
second = []
for i in range(0, 151):
    f.append(0)
while 1:
    bio = 0
    for i in range(0, n):
        if 10 * k + 10 + index >= len(out):
            k = 0
            index = index + 1
        temp = out[10 * k + index:10 * k + 10 + index]
        # print("temp : " + temp)
        x = int(temp, 2)
        if x <= p:
            bio = bio + 1
        elif x >= 1000:
            i = i - 1
        k = k + 1
    first.append(bio)
    if len(first) == 10000:
        break
k = 0
while 1:
    temp = out[6 * k:6 * k + 6]
    if 1 <= int(temp, 2) <= uniform:
        second.append(int(temp, 2))
    k = k + 1
    if len(second) == 10000:
        # print("works properly")
        break
for i in range(0, 10000):
    z.append(first[i] + second[i])
e = 0
for i in range(0, len(z)):
    e = e + z[i]
e = e / len(z)
print("E[Z] = " + str(e))
v = []
for i in range(0, len(z)):
    v.append(z[i] * z[i])
t = 0
for i in range(0, len(v)):
    t = t + v[i]
t = t / len(v)
var = t - (e * e)
print("Var[Z] = " + str(var))
for i in range(0, len(z)):
    f[z[i]] = f[z[i]] + 1
for i in range(0, len(f)):
    f[i] = f[i] / len(z)
x = []
# print(f)
for i in range(0, 151):
    x.append(i)
# plt.xlabel("x")
# plt.ylabel("f(x)")
plt.title("probability mass function of Z")
# plt.figure(figsize=(20, 3))
# plt.xticks(x, x)
plt.bar(x, f, width=0.5)
plt.show()
# plt.bar(z, bins=40)
# plt.show()
