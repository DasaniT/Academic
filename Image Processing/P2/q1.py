import cv2
import numpy as np

image = cv2.imread('./flowers_blur.png')
kernel = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]], dtype=np.float64)
blue = cv2.filter2D(image[:, :, 0], -1, cv2.flip(kernel, -1)).astype(np.float64)
green = cv2.filter2D(image[:, :, 1], -1, cv2.flip(kernel, -1)).astype(np.float64)
red = cv2.filter2D(image[:, :, 2], -1, cv2.flip(kernel, -1)).astype(np.float64)
result = cv2.merge((blue, green, red))
cv2.imwrite('./res01.jpg', result)
res = image + result * 2
cv2.imwrite('./res02.jpg', res)
