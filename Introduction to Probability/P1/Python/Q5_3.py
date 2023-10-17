import Snow_3g

out = Snow_3g.out

num = 0
z = []
for i in range(0, 200000):
    num = num + 1
    temp = out[i * 5:i * 5 + 5]
    x = int(temp, 2)
    if x == 3:
        z.append(4)
    elif x == 4 or x == 5:
        z.append(-1)
    elif x == 6 or x == 7 or x == 8:
        z.append(2)
    elif x == 10:
        z.append(2)
    elif x == 20 or x == 21 or x == 22:
        z.append(7)
    if len(z) == 10000:
        break
print("number of : " + str(num))
# print(len(z))
