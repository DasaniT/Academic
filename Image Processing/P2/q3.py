import cv2
import numpy as np


def compute(source, destination):
    a = np.zeros((8, 8), dtype=np.float32)
    b = np.zeros(8, dtype=np.float32)
    for i in range(4):
        a[i][0] = a[i + 4][3] = source[i][0];
        a[i][1] = a[i + 4][4] = source[i][1];
        a[i][2] = a[i + 4][5] = 1;
        a[i][3] = a[i][4] = a[i][5] = a[i + 4][0] = a[i + 4][1] = a[i + 4][2] = 0;
        a[i][6] = -source[i][0] * destination[i][0];
        a[i][7] = -source[i][1] * destination[i][0];
        a[i + 4][6] = -source[i][0] * destination[i][1];
        a[i + 4][7] = -source[i][1] * destination[i][1];
        b[i] = destination[i][0];
        b[i + 4] = destination[i][1];
    return np.linalg.solve(a, b)


# source = np.float32([[663,213], [600,391], [380,110], [321,286]])
# destination = np.float32([[0,0], [190,0], [0,300], [190,300]])

source = np.float32([[213, 663], [391, 600], [110, 380], [286, 321]])
destination = np.float32([[0, 0], [0, 188], [301, 0], [301, 188]])

temp = compute(source, destination)

h = np.float32([[temp[0], temp[1], temp[2]], [temp[3], temp[4], temp[5]], [temp[6], temp[7], 1]])
inverse_h = np.linalg.inv(h)

image = cv2.imread('books.jpg')
# dst = cv2.warpPerspective(image, h, (190,300))
dst = np.zeros((301, 188, 3), dtype=np.uint8)
for i in range(301):
    for j in range(188):
        temp = np.matmul(inverse_h, np.float32([i, j, 1]))
        temp = temp / temp[2]
        # print(temp)
        temp = temp.astype(np.uint32)
        # if i == 0 and j == 0:
        #     print(temp)
        temp[temp < 0] = 0
        dst[i][j][0] = image[temp[0]][temp[1]][0]
        dst[i][j][1] = image[temp[0]][temp[1]][1]
        dst[i][j][2] = image[temp[0]][temp[1]][2]

cv2.imwrite('res04.jpg', dst)

source = np.float32([[736, 350], [708, 156], [466, 396], [429, 205]])
destination = np.float32([[0, 0], [0, 196], [274, 0], [274, 196]])

temp = compute(source, destination)

h = np.float32([[temp[0], temp[1], temp[2]], [temp[3], temp[4], temp[5]], [temp[6], temp[7], 1]])
inverse_h = np.linalg.inv(h)

image = cv2.imread('books.jpg')
# dst = cv2.warpPerspective(image, h, (190,300))
dst = np.zeros((274, 196, 3), dtype=np.uint8)
for i in range(274):
    for j in range(196):
        temp = np.matmul(inverse_h, np.float32([i, j, 1]))
        temp = temp / temp[2]
        # print(temp)
        temp = temp.astype(np.uint32)
        # if i == 0 and j == 0:
        #     print(temp)
        temp[temp < 0] = 0
        dst[i][j][0] = image[temp[0]][temp[1]][0]
        dst[i][j][1] = image[temp[0]][temp[1]][1]
        dst[i][j][2] = image[temp[0]][temp[1]][2]

cv2.imwrite('res05.jpg', dst)

source = np.float32([[968, 798], [1095, 609], [676, 616], [795, 429]])
destination = np.float32([[0, 0], [0, 228], [334, 0], [334, 228]])

temp = compute(source, destination)

h = np.float32([[temp[0], temp[1], temp[2]], [temp[3], temp[4], temp[5]], [temp[6], temp[7], 1]])
inverse_h = np.linalg.inv(h)

image = cv2.imread('books.jpg')
# dst = cv2.warpPerspective(image, h, (190,300))
dst = np.zeros((334, 228, 3), dtype=np.uint8)
for i in range(334):
    for j in range(228):
        temp = np.matmul(inverse_h, np.float32([i, j, 1]))
        temp = temp / temp[2]
        # print(temp)
        temp = temp.astype(np.uint32)
        # if i == 0 and j == 0:
        #     print(temp)
        temp[temp < 0] = 0
        dst[i][j][0] = image[temp[0]][temp[1]][0]
        dst[i][j][1] = image[temp[0]][temp[1]][1]
        dst[i][j][2] = image[temp[0]][temp[1]][2]

# dst = cv2.warpPerspective(image, h, (190,300))
cv2.imwrite('res06.jpg', dst)
