import cv2
import numpy as np

image = cv2.imread('./Dark.jpg')
alpha = 0.1
image = (255 * np.log(1 + alpha * image))/np.log(1+255*alpha)
cv2.imwrite('res01.jpg', image)
