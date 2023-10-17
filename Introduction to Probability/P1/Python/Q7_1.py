import Snow_3g
import math

out = Snow_3g.out

p = float(input("Enter P\n"))
p = p * 1000
p = math.floor(p)
k = 0
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
    print(numOfTry)
