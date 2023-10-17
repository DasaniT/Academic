import Snow_3g
import math

out = Snow_3g.out

n = int(input("Enter n\n"))
p = float(input("Enter p\n"))

p = p * 1000
p = math.floor(p)
k = 0
for j in range(0, 150):
    bio = 0
    for i in range(0, n):
        temp = out[10 * k:10 * k + 10]
        x = int(temp, 2)
        if x <= p:
            bio = bio + 1
        elif x > 1000:
            i = i - 1
        k = k + 1
    print(bio)
