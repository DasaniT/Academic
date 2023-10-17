import Snow_3g
import math

out = Snow_3g.out

n = int(input("Enter n \n"))
# print(math.ceil(math.log2(n)))
bits = math.ceil(math.log2(n))
j = 0
for i in range(0, 100):
    temp = out[j * bits:bits + j * bits]
    # print("temp " + temp)
    # print(int(temp, 2))
    if 1 <= int(temp, 2) <= n:
        print(int(temp, 2))
        j = j + 1
    else:
        j = j + 1
        i = i - 1
