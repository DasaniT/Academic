import math
import matplotlib.pyplot as plt

x = []
y = []
for i in range(2, 1001):
    n = i
    p = 0
    for j in range(1, n + 1):
        count = 0
        for k in range(1, n + 1):
            if j == k:
                continue
            if math.gcd(j, k) == 1:
                count = count + 1
        count = count / (n - 1)
        count = count * (1 / n)
        p = p + count
    y.append(p)
for i in range(2, 1001):
    x.append(i)
plt.plot(x, y)
plt.show()
