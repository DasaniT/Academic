import cv2
import numpy as np
from sklearn.cluster import MeanShift, estimate_bandwidth

image = cv2.imread('park.jpg')
image = cv2.resize(image, (image.shape[1] // 8, image.shape[0] // 8))
image = cv2.GaussianBlur(image, (5, 5), 1.5)
image = np.array(image)

flat_image = np.reshape(image, [-1, 3])

bandwidth = estimate_bandwidth(flat_image, quantile=0.05, n_samples=50)
ms = MeanShift(bandwidth=bandwidth, bin_seeding=True)
ms.fit(flat_image)
labels = ms.labels_

cluster_centers = ms.cluster_centers_

segmented = cluster_centers[np.reshape(labels, image.shape[:2])]
cv2.imwrite('res04.jpg', segmented.astype(np.uint8))
