import cv2
import numpy as np
from skimage.segmentation import mark_boundaries


class SuperPixel():
    def __init__(self, h, w, l=0, a=0, b=0):
        self.populate(h, w, l, a, b)
        self.pixels = []

    def populate(self, h, w, l, a, b):
        self.h = h
        self.w = w
        self.l = l
        self.a = a
        self.b = b


def compute_grad(image, h, w, gradients):
    return np.sum(gradients[h][w])


def cluster_centers(s, image, height, width):
    h = s // 2
    w = s // 2
    a = np.arange(h, height + 1, s)
    b = np.arange(w, width + 1, s)
    super_pixels = []
    for i in a:
        for j in b:
            pixel = image[i][j]
            super_pixel = SuperPixel(i, j, pixel[0], pixel[1], pixel[2])
            super_pixels.append(super_pixel)

    return super_pixels


def refine_cluster_centers(super_pixels, image, gradients):
    for sp in super_pixels:
        sp_grad = compute_grad(image, sp.h, sp.w, gradients)
        for i in range(-2, 3):
            for j in range(-2, 3):
                h = sp.h + i
                w = sp.w + j
                temp_grad = compute_grad(image, h, w, gradients)
                if temp_grad < sp_grad:
                    pixel = image[h][w]
                    sp.populate(h, w, pixel[0], pixel[1], pixel[2])
                    sp_grad = temp_grad


image = cv2.imread('slic.jpg')
sobelx = cv2.Sobel(image, cv2.CV_64F, 1, 0, ksize=3)
sobely = cv2.Sobel(image, cv2.CV_64F, 0, 1, ksize=3)
gradients = cv2.magnitude(sobelx, sobely)
image = cv2.GaussianBlur(image, (5, 5), 15)
image = cv2.cvtColor(image, cv2.COLOR_BGR2LAB)
# image = cv2.resize(image, (3024//8, 4032//8))

height = image.shape[0]
width = image.shape[1]
n = height * width
ks = [64, 256, 1024, 2048]
alpha = 2500
fn = 5
for k in ks:
    s = int(np.sqrt(n / k))
    distances = np.full((height, width), np.inf)
    super_pixels = cluster_centers(s, image, height, width)
    refine_cluster_centers(super_pixels, image, gradients)
    labels = np.full((height, width), -1)
    grid = np.mgrid[0:width, 0:width]
    grid = grid.T
    for j in range(10):
        for i in range(len(super_pixels)):
            sp = super_pixels[i]
            h_start = max(sp.h - s, 0)
            h_end = min(sp.h + s + 1, height)
            w_start = max(sp.w - s, 0)
            w_end = min(sp.w + s + 1, width)
            temp_h = np.arange(h_start, h_end)
            temp_w = np.arange(w_start, w_end)
            temp = image[h_start: h_end, w_start:w_end].astype(np.float32)
            d_lab = np.sum((temp - image[sp.h][sp.w]) ** 2, axis=2)
            temp_grid = grid[h_start:h_end, w_start:w_end]
            d_xy = np.sum(((temp_grid - [sp.w, sp.h]) ** 2) / (s ** 2), axis=2)
            d = np.sqrt(d_lab + alpha * d_xy)
            dist = d - distances[h_start:h_end, w_start:w_end]
            diff = np.argwhere(dist < 0)
            diff = diff + [h_start, w_start]
            distances[diff[:, 0], diff[:, 1]] = d[diff[:, 0] - h_start, diff[:, 1] - w_start]
            labels[diff[:, 0], diff[:, 1]] = i
            summ = np.sum(diff, axis=0)
            hh = summ[0] // len(diff)
            ww = summ[1] // len(diff)
            sp.populate(hh, ww, image[hh][ww][0], image[hh][ww][1], image[hh][ww][2])
    image = cv2.cvtColor(image, cv2.COLOR_LAB2BGR)
    t = mark_boundaries(image, labels, color=(0, 0, 1))
    t = t * 255
    name = 'res0' + str(fn) + '.jpg'
    fn = fn + 1
    cv2.imwrite(name, t)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2LAB)
