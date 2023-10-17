import Snow_3g
import math
import matplotlib.pyplot as plt

out = Snow_3g.out

p = 0.3
p = p * 1000
p = math.floor(p)
index = 0
k = 0
x1 = []
y1 = []
for j in range(0, 10000):
    numOfTry = 1
    flag = 0
    while 1:
        if flag:
            break
        for i in range(k, 100000):
            if 10 * k + 10 + index > 1000000:
                k = 0
                index = index + 1
            temp = out[10 * k + index:10 * k + 10 + index]
            x = int(temp, 2)
            if x <= p:
                flag = 1
                k = k + 1
                x1.append(numOfTry)
                break
            elif p < x < 1000:
                numOfTry = numOfTry + 1
            k = k + 1
        if flag:
            break

for i in range(0, 50):
    y1.append(0)
for i in range(0, len(x1)):
    y1[x1[i]] = y1[x1[i]] + 1
# plt.plot(x1, y1)
# plt.show()
for i in range(0, len(y1)):
    y1[i] = y1[i] / 10000
x2 = []
for i in range(0, 50):
    x2.append(i)
plt.title("Geometric distribution , p = 0.3")
plt.plot(x2, y1)
plt.show()
