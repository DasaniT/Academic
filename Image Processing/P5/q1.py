import cv2
import numpy as np
import scipy.sparse
from scipy.sparse.linalg import spsolve
from scipy.sparse import csr_matrix


def create_A(n, m):
    D = np.zeros((m, m), dtype=np.float32)
    np.fill_diagonal(D, 4)
    np.fill_diagonal(D[1:], -1)
    np.fill_diagonal(D[:, 1:], -1)

    A = scipy.sparse.block_diag([D] * n).tolil()

    A.setdiag(-1, m)
    A.setdiag(-1, -m)

    return A


# a = create_A(12, 3)
# a

source = cv2.imread('./source.jpg', 1)
target = cv2.imread('./target.jpg', 1)
mask = cv2.imread('./mask.jpg', 0)

height = target.shape[0]
width = target.shape[1]

A = create_A(height, width)
laplacian = A.tocsc()

mask_flatten = mask.flatten()
wh = np.where(mask_flatten == 0)
wh = np.array(wh)
bound = height * width
wh = wh[0]
A[wh, wh] = 1
wh_copy = np.copy(wh)
temp = wh_copy - 1
wh_copy = np.delete(wh_copy, np.where(temp < 0))
temp = np.delete(temp, np.where(temp < 0))
A[wh_copy, temp] = 0
wh_copy = np.copy(wh)
temp = wh_copy + 1
wh_copy = np.delete(wh_copy, np.where(temp >= bound))
temp = np.delete(temp, np.where(temp >= bound))
A[wh_copy, temp] = 0
wh_copy = np.copy(wh)
temp = wh_copy - width
wh_copy = np.delete(wh_copy, np.where(temp < 0))
temp = np.delete(temp, np.where(temp < 0))
A[wh_copy, temp] = 0
wh_copy = np.copy(wh)
temp = wh_copy + width
wh_copy = np.delete(wh_copy, np.where(temp >= bound))
temp = np.delete(temp, np.where(temp >= bound))
A[wh_copy, temp] = 0

for i in range(3):
    target_flatten = np.float32(target[:, :, i].flatten())
    laplac_flatten = laplacian.dot(source[:, :, i].flatten())
    laplac_flatten_target = laplacian.dot(target[:, :, i].flatten())
    b = np.zeros(height * width, dtype=np.float32)
    wh = np.where(mask_flatten == 0)
    wh = np.array(wh)
    wh = wh[0]
    b[wh] = target_flatten[wh]
    whh = np.where(mask_flatten != 0)
    whh = whh[0]
    b[whh] = laplac_flatten[whh] * 0.8 + laplac_flatten_target[whh] * 0.35
    x = spsolve(csr_matrix(A), b)
    x = x / np.amax(x)
    x = x * 255
    x[x < 0] = 0

    x = x.reshape((height, width))
    x = np.uint8(x)

    target[:, :, i] = x

cv2.imwrite('res1.jpg', target)
