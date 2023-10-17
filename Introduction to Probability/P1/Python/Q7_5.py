import Snow_3g
import math
import matplotlib.pyplot as plt

out = Snow_3g.out

p = 0.2
p = p * 1000
p = math.floor(p)
k = 0
X = []
for j in range(0, 10000):
    numOfTry = 1
    flag = 0
    while 1:
        if flag:
            break
        for i in range(k, 100000):
            temp = out[10 * k:10 * k + 10]
            x = int(temp, 2)
            if x <= p:
                flag = 1
                k = k + 1
                break
            elif p < x < 1000:
                numOfTry = numOfTry + 1
            k = k + 1

        if flag:
            break
    if numOfTry >= 3:
        X.append(numOfTry)
maxx = -100
x1 = []
for i in range(0, 50):
    x1.append(i)
y1 = []
for i in range(0, 50):
    y1.append(0)
length = len(X)
for i in range(0, length):
    y1[X[i]] = y1[X[i]] + 1
for i in range(0, len(y1)):
    y1[i] = y1[i] / length

plt.title("probability mass function of X")
# plt.figure(figsize=(20, 3))
# plt.xticks(x, x)
plt.bar(x1, y1, width=0.5)
plt.show()

