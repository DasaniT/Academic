import cv2
import numpy as np
import matplotlib.pyplot as plt

dark = cv2.imread('Dark.jpg')
pink = cv2.imread('Pink.jpg')
p_dark = []
p_pink = []
mapp = []
for k in range(3):
    row, column = dark[:,:,k].shape
    p_dark.append(cv2.calcHist([dark],[k],None,[256],[0,256])/(row*column))
    row, column = pink[:,:,k].shape
    p_pink.append(cv2.calcHist([pink], [k], None, [256], [0,256])/(row*column))
    p_dark_cum = np.cumsum(p_dark[k])
    p_pink_cum = np.cumsum(p_pink[k])

    s = np.array([255 * p_dark_cum[i] for i in range(256)]).astype(int)
    g = np.array([255 * p_pink_cum[i] for i in range(256)]).astype(int)

    mapp.append(np.array([np.abs(ss - g).argmin() for ss in s]))

blue = mapp[0][dark[:,:,0]]
green = mapp[1][dark[:,:,1]]
red = mapp[2][dark[:,:,2]]
dark = cv2.merge((blue,green,red))

plt.subplot(3, 1, 1)
plt.hist(x= blue.flatten(), bins=np.arange(256))
plt.subplot(3, 1, 2)
plt.hist(x= red.flatten(), bins=np.arange(256))
plt.subplot(3, 1, 3)
plt.hist(x= green.flatten(), bins=np.arange(256))
plt.savefig('res05.jpg')

dark = dark.astype(np.uint8)
dark = cv2.medianBlur(dark, 7)
cv2.imwrite('res06.jpg', dark)
