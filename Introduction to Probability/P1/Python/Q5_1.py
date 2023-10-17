import Snow_3g

out = Snow_3g.out
k = 0
for i in range(0, 100):
    for j in range(k, 2000):
        temp = out[j * 5:j * 5 + 5]
        x = int(temp, 2)
        if x == 0:
            print("X = -1 , Y = -1")
            k = k + 1
            break
        elif x == 1 or x == 2:
            print("X = -1 , Y = 1")
            k = k + 1
            break
        elif x == 3:
            print("X = -1 , Y = 3")
            k = k + 1
            break
        elif x == 4 or x == 5:
            print("X = 0 , Y = -1")
            k = k + 1
            break
        elif x == 6 or x == 7 or x == 8:
            print("X = 0 , Y = 2")
            k = k + 1
            break
        elif x == 9:
            print("X = 0 , Y = 3")
            k = k + 1
            break
        elif x == 10:
            print("X = 1 , Y = -1")
            k = k + 1
            break
        elif x == 11 or x == 12:
            print("X = 1 , Y = 1")
            k = k + 1
            break
        elif x == 13 or x == 14 or x == 15 or x == 16:
            print("X = 1 , Y = 3")
            k = k + 1
            break
        elif x == 17:
            print("X = 2 , Y = 1")
            k = k + 1
            break
        elif x == 18 or x == 19:
            print("X = 2 , Y = 2")
            k = k + 1
            break
        elif x == 20 or x == 21 or x == 22:
            print("X = 2 , Y = 3")
            k = k + 1
            break
        k = k + 1
