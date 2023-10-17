import cv2
import numpy as np


def distance(p1, p2):
    distance = np.sqrt(((p1[0] - p2[0]) ** 2) + ((p1[1] - p2[1]) ** 2))
    return distance


def compute(image_patch, patch, w, h):
    patch_mean = np.sum(patch) / (w * h)
    image_mean = np.sum(image_patch) / (w * h)
    a = (patch - patch_mean) * (image_patch - image_mean)
    a = np.sum(a)
    b = np.sum((patch - patch_mean) ** 2) * np.sum((image_patch - image_mean) ** 2)
    return a / np.sqrt(b)


def normalized_cross_correlation(image, patch, flag=False, x=None, y=None):
    hh = np.full((image.shape[0], image.shape[1]), 0, dtype=np.float64)
    w, h = patch.shape[::-1]
    if not flag:
        for i in range(image.shape[0] - h):
            for j in range(image.shape[1] - w):
                temp = compute(image[i:i + h, j:j + w], patch, w, h)
                hh[i][j] = temp
        return hh
    else:
        for k in range(len(x)):
            start = x[k] - 1 if x[k] >= 1 else 0
            start_y = y[k] - 1 if y[k] >= 1 else 0
            end = x[k] + 1 if x[k] + 1 < image.shape[0] - h else image.shape[0] - h
            end_y = y[k] + 1 if y[k] + 1 < image.shape[1] - h else image.shape[1] - 2
            for i in range(start, end):
                for j in range(start_y, end_y):
                    if i + h < image.shape[0] and j + w < image.shape[1]:
                        temp = compute(image[i:i + h, j:j + w], patch, w, h)
                        hh[i][j] = temp
        return hh


image = cv2.imread('Greek_ship.jpg')
image_gray = cv2.imread('Greek_ship.jpg', 0)
img2 = image_gray.copy()
patch = cv2.imread('patch.png', 0)
# ww = patch.shape[1]
# hh = patch.shape[0]
# patch = patch[78:78+312, 77:77+48]
w = patch.shape[1]
h = patch.shape[0]
w_i = img2.shape[1]
h_i = img2.shape[0]
blue = (cv2.GaussianBlur(img2, (5, 5), 0)).astype(np.float64)
patch = (cv2.GaussianBlur(patch, (5, 5), 0)).astype(np.float64)

image_pyramid = []
patch_pyramid = []
for i in range(5):
    image_pyramid.append(cv2.resize(blue, (w_i // (2 ** i), h_i // (2 ** i))))
    patch_pyramid.append(cv2.resize(patch, (w // (2 ** i), h // (2 ** i))))

flag = False
x = []
y = []
number = 10
for i in range(5):
    hh = normalized_cross_correlation(image_pyramid[4 - i], patch_pyramid[4 - i], flag=flag, x=x,
                                      y=y)
    x = []
    y = []
    hhh = np.copy(hh)
    for j in range(number):
        min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(hhh)
        # hhh[max_loc[1]][max_loc[0]] = 0
        hhh[hhh > max_val - 0.01] = 0
        # hhh[max_loc[1]:max_loc[1]+h, max_loc[0]:max_loc[0]+ w] = 0
        if max_loc[0] != 0 and max_loc[1] != 0:
            x.append(max_loc[1] * 2)
            y.append(max_loc[0] * 2)
    flag = True

# min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(hh)
x = np.array(x) // 2
y = np.array(y) // 2
p1 = [x[0], y[0]]
p2 = [x[1], y[1]]
removal = []
for i in range(len(x)):
    p1 = [x[i], y[i]]
    for j in range(i + 1, len(x)):
        p2 = [x[j], y[j]]
        if distance(p1, p2) < 50:
            removal.append(i)
            break

x = np.delete(x, removal)
y = np.delete(y, removal)

for i in range(len(x)):
    cv2.rectangle(image, (y[i], x[i]), (y[i] + w, x[i] + h), 255, 2)

cv2.imwrite('res03.jpg', image)
