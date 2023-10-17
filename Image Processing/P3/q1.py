import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans

points = open('Points.txt', 'r')
number = int(points.readline())
p = []
for line in points:
    temp = str(line).split(' ')
    tempp = [float(temp[0]), float(temp[1])]
    p.append(tempp)

p = np.float32(p)
plt.scatter(p[:, 0], p[:, 1])
plt.xlabel('x')
plt.ylabel('y')
plt.savefig('res01.jpg')
plt.show()

kmeans = KMeans(n_clusters=2)
kmeans.fit(p)
a = []
b = []
for i in range(number):
    if kmeans.labels_[i] == 0:
        a.append(p[i])
    else:
        b.append(p[i])

a = np.float32(a)
b = np.float32(b)
# plt.scatter(p[:,0], p[:,1])
plt.scatter(a[:, 0], a[:, 1])
plt.scatter(b[:, 0], b[:, 1], c='green')
plt.scatter(kmeans.cluster_centers_[:, 0], kmeans.cluster_centers_[:, 1], s=10, c='red')
plt.savefig('res02.jpg')
plt.show()
