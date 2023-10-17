import cv2
import math
import numpy as np


def click_event(event, x, y, flags, params):
    if event == cv2.EVENT_LBUTTONDOWN:

        # cv2.circle(img, (x,y),1,(0,255,0), 1)
        # print(x)
        # print(y)
        points.append([y, x])
        cv2.imshow('tasbih', img)
        if len(points) == 40:
            cv2.waitKey(1000)
            cv2.destroyAllWindows()


def vertex_coordinates(x, y, index, m):
    index = int(index)
    m = int(np.sqrt(m))
    switch = {}
    for i in range(- (m // 2), m // 2 + 1):
        for j in range(-(m // 2), m // 2 + 1):
            switch[str((i + m // 2) * m + (j + m // 2))] = (i, j)
    k = switch[str(index)]
    return (x + k[0], y + k[1])


def initialize_points(points):
    if len(points) == 0:
        points = [[297, 201], [228, 239], [219, 267], [196, 317], [182, 380],
                  [165, 466], [165, 525], [192, 578], [210, 604], [221, 639],
                  [237, 705], [248, 758], [258, 828], [273, 870], [301, 927],
                  [334, 951], [382, 962], [389, 881], [400, 824], [404, 758],
                  [418, 708], [434, 663], [458, 650], [478, 609], [499, 584],
                  [522, 557], [558, 494], [580, 461], [603, 416], [607, 369],
                  [602, 324], [574, 296], [546, 288], [514, 273], [493, 273],
                  [466, 265], [438, 245], [410, 227], [383, 207], [357, 209]]
    return points


def distance(x_1, y_1, x_2, y_2):
    return math.dist([x_1, y_1], [x_2, y_2])


def contour_length(points):
    l = 0
    for i in range(n):
        x1 = points[i][0]
        y1 = points[i][1]
        if i + 1 == n:
            x2 = points[0][0]
            y2 = points[0][1]
        else:
            x2 = points[i + 1][0]
            y2 = points[i + 1][1]
        l = l + distance(x1, y1, x2, y2)
    return l


def e_internal(x_1, y_1, x_2, y_2):
    alpha = 0.1
    d = (contour_length(points) * 0.95) / n
    return alpha * (distance(x_1, y_1, x_2, y_2) ** 2 - (d ** 2))


def e_external(x, y, gradients):
    gamma = 1000
    return -((gradients[x][y] ** 2) * gamma)


def compute_column(energy_matrix, column, points, gradients, path):
    m = len(energy_matrix[:, column])
    for i in range(m):
        x, y = vertex_coordinates(points[column][0], points[column][1], i, m)
        external = e_external(x, y, gradients)
        # print(external)
        energy = np.inf
        offset = -1
        for j in range(m):
            x2, y2 = vertex_coordinates(points[column - 1][0], points[column - 1][1], j, m)
            internal = e_internal(x, y, x2, y2)
            if internal + external + energy_matrix[j][column - 1] < energy:
                energy = internal + external + energy_matrix[j][column - 1]
                offset = j
        energy_matrix[i][column] = energy
        path[i][column] = offset


def find_path(path, last):
    a = []
    a.append(last)
    for i in range(path.shape[1] - 1, 0, -1):
        temp = path[:, i][int(a[i - path.shape[1] + 1])]
        # print(temp)
        a.append(temp)
    a.reverse()
    return a


def update_point(point, min_path):
    x, y = vertex_coordinates(point[0], point[1], int(min_path), 25)
    return (x, y)


def update(e, points, path):
    n = len(points)
    first = []
    for i in range(m):
        min_first = find_path(path, i)[0]
        x1, y1 = vertex_coordinates(points[0][0], points[0][1], min_first, m)
        x2, y2 = vertex_coordinates(points[n - 1][0], points[n - 1][0], i, m)
        internal = e_internal(x1, y1, x2, y2)
        external = e_external(x1, y1, gradients)
        first.append(internal + external + e[i][n - 1])

    first = np.float32(first)
    last = np.argmin(first)
    min_path = find_path(path, last)
    # print(min_path)
    for i in range(len(points)):
        x, y = update_point(points[i], min_path[i])
        points[i] = [x, y]


img = cv2.imread('tasbih.jpg')
# img2 = np.copy(img)
points = []
# img = cv2.resize(img, (1104//16, 828//16))
img = cv2.GaussianBlur(img, (5, 5), 0.5)
cv2.imshow('tasbih', img)
cv2.setMouseCallback('tasbih', click_event)
cv2.waitKey(0)

# image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
image = np.copy(img)
points = initialize_points(points)
height = image.shape[0]
width = image.shape[1]
# sobelx = cv2.Sobel(image,cv2.CV_64F,1,0,ksize=3)
# sobely = cv2.Sobel(image,cv2.CV_64F,0,1,ksize=3)
# gradients = cv2.magnitude(sobelx,sobely)
# gradients = np.zeros((height, width)).astype(np.float32)
gradients = cv2.Canny(image, 30, 250)

m = 25
n = len(points)

for i in range(len(points)):
    x1 = points[i][0]
    y1 = points[i][1]
    if i + 1 != len(points):
        x2 = points[i + 1][0]
        y2 = points[i + 1][1]
    else:
        x2 = points[0][0]
        y2 = points[0][1]
    cv2.line(img, (y1, x1), (y2, x2), (0, 0, 255), thickness=1)
img_array = []
for z in range(200):
    e = np.zeros((m, n)).astype(np.float32)
    g = []
    for i in range(m):
        x, y = vertex_coordinates(points[0][0], points[0][1], i, m)
        g.append(-((gradients[x][y] ** 2) * 1000))
    e[:, 0] = np.float32(g)
    path = np.zeros((m, n))
    for i in range(1, n):
        compute_column(e, i, points, gradients, path)
    update(e, points, path)
    if z % 20 == 0:
        img2 = np.copy(img)
        for i in range(len(points)):
            x1 = points[i][0]
            y1 = points[i][1]
            if i + 1 != len(points):
                x2 = points[i + 1][0]
                y2 = points[i + 1][1]
            else:
                x2 = points[0][0]
                y2 = points[0][1]
            cv2.line(img2, (y1, x1), (y2, x2), (255, 0, 0), thickness=1)
        img_array.append(img2)
    # cv2.imwrite('pointaya.jpg', img)
# for point in points:
#     cv2.line(image, (x1, y1), (x2, y2), (0, 255, 0), thickness=line_thickness)
#     cv2.circle(img, (point[0],point[1]), radius=2, color=(0, 0, 255), thickness=1)
for i in range(len(points)):
    x1 = points[i][0]
    y1 = points[i][1]
    if i + 1 != len(points):
        x2 = points[i + 1][0]
        y2 = points[i + 1][1]
    else:
        x2 = points[0][0]
        y2 = points[0][1]
    cv2.line(img, (y1, x1), (y2, x2), (255, 0, 0), thickness=1)
cv2.imwrite('res10.jpg', img)
# out = cv2.VideoWriter('contour.mp4',cv2.VideoWriter_fourcc('M','J','P','G'), 1, (image.shape))
# for i in range(len(img_array)):
#     out.write(img_array[i])
# out.release()
# cv2.imwrite('edges.jpg', gradients)
