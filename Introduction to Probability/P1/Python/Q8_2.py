import Snow_3g
import math
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

out = Snow_3g.out

n = 5
bits = math.ceil(math.log2(n))
j = 0
z_2 = []
index = 0
temporary = 0
iterator = 0
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 2 == 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 6
            temporary = temporary / math.sqrt(4)
            z_2.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_2) == 10000:
        break
sns.distplot(z_2, hist=False, label="n=2")
z_3 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 3 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 9
            temporary = temporary / math.sqrt(6)
            z_3.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_3) == 10000:
        break
sns.distplot(z_3, hist=False, label="n=3")
z_4 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 4 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 12
            temporary = temporary / math.sqrt(8)
            z_4.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_4) == 10000:
        break
sns.distplot(z_4, hist=False, label="n=4")
z_5 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 5 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 15
            temporary = temporary / math.sqrt(10)
            z_5.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_5) == 10000:
        break
sns.distplot(z_5, hist=False, label="n=5")

z_7 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 7 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 21
            temporary = temporary / math.sqrt(14)
            z_7.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_7) == 10000:
        break
sns.distplot(z_7, hist=False, label="n=7")

z_10 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > 1000000:
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 10 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 30
            temporary = temporary / math.sqrt(20)
            z_10.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_10) == 10000:
        break
sns.distplot(z_10, hist=False, label="n=10")

z_30 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > len(out):
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 30 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 90
            temporary = temporary / math.sqrt(60)
            z_30.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_30) == 10000:
        break
sns.distplot(z_30, hist=False, label="n=30")

z_50 = []
j = 0
index = 0
iterator = 1
while 1:
    if bits + j * bits > len(out):
        j = 0
        index = index + 1
    temp = out[j * bits + index:bits + j * bits + index]
    x = int(temp, 2)
    if 1 <= x <= n:
        if iterator % 50 != 0:
            temporary = temporary + x
        else:
            temporary = temporary + x
            temporary = temporary - 150
            temporary = temporary / math.sqrt(100)
            z_50.append(temporary)
            temporary = 0
        iterator = iterator + 1
    j = j + 1
    if len(z_50) == 10000:
        break
sns.distplot(z_50, hist=False, label="n=50")
plt.title("Distribution Function of 8.2")
plt.legend()
plt.show()
