import cv2
import numpy as np
from skimage.segmentation import felzenszwalb
from skimage.segmentation import mark_boundaries

image = cv2.imread('./birds.jpg')
# image = cv2.resize(image, (image.shape[1] // 8, image.shape[0] // 8))
imagee = image[1497:2409]

segmented = felzenszwalb(imagee, scale=500, sigma=1.8, min_size=500)
segmentedd = np.zeros((image.shape[0], image.shape[1])).astype(np.int64)
segmentedd[1497:2409] = segmented
patch = cv2.imread('patch.jpg', 0)
img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

a = np.sum(patch) / (patch.shape[0] * patch.shape[1])
mm = np.max(segmented)


for i in range(mm):
    b = np.argwhere(segmentedd==i)
    if len(b) < 1000:
        segmentedd[b[:,0], b[:,1]] = 0
        continue
    if len(b) > 80000:
        segmentedd[b[:,0], b[:,1]] = 0
        continue
    c = img[b[:,0], b[:,1]]
    d = np.sum(c) / len(b)
    if d < a - 35 or d > a + 35:
        segmentedd[b[:,0], b[:,1]] = 0
segmented = mark_boundaries(image, segmentedd, color=(0,0,1))
segmented = segmented * 255
cv2.imwrite('res09.jpg', segmented)