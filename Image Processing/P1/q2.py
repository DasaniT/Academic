import cv2
import numpy as np

image = cv2.imread('Yellow.jpg')

image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

image_hue = image[900:2600,:,0]
image_hue[np.logical_and(image_hue<=30, image_hue>=20)] = 0


image = cv2.cvtColor(image, cv2.COLOR_HSV2BGR)


cv2.imwrite('res02.jpg', image)


image = cv2.imread('Pink.jpg')

image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)


image_hue = image[:,:,0]
image_hue[np.logical_or(np.logical_and(image_hue<= 200, image_hue>=140), np.logical_and(image_hue>=0, image_hue<=15))] = 120

image = cv2.cvtColor(image, cv2.COLOR_HSV2BGR)

cv2.imwrite('res03.jpg', image)
