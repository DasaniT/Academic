import Snow_3g
import math

out = Snow_3g.out

p = float(input("Enter p\n"))
p = p * 1000
p = math.floor(p)
for i in range(0, 1000):
    temp = out[10 * i: 10 * i + 10]
    # print("out : " + temp)
    # print("int(temp,2) : " + str(int(temp,2)))
    if int(temp, 2) <= p:
        print("1")
    elif p < int(temp, 2) <= 1000:
        print("0")
