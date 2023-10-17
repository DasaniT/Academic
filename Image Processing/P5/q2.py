import cv2
import numpy as np

basketball = cv2.imread('./basketball.jpg', 1)
volleyball = cv2.imread('./volleyball.jpg', 1)
# mask = cv2.imread('/content/mask.jpg', 0)


# mask[mask==255] = 1

basketball_pyr = []
volleyball_pyr = []
# mask_pyr = []
temp_basketball = np.copy(basketball)
temp_volleyball = np.copy(volleyball)
# temp_mask = np.copy(mask)
n = 4
for i in range(n):
    basketball_pyr.append(temp_basketball)
    temp_basketball = cv2.pyrDown(temp_basketball)
    volleyball_pyr.append(temp_volleyball)
    temp_volleyball = cv2.pyrDown(temp_volleyball)
    # mask_pyr.append(temp_mask)
    # temp_mask = cv2.pyrDown(temp_mask)

laplacian_volleyball_pyramid = [volleyball_pyr[n - 1]]
laplacian_basketball_pyramid = [basketball_pyr[n - 1]]
# laplacian_mask_pyramid = [msak_pyr[n-1]]
for i in range(n - 1, 0, -1):
    temp_voll = cv2.pyrUp(volleyball_pyr[i])
    laplacian_volleyball_pyramid.append(cv2.subtract(volleyball_pyr[i - 1], temp_voll))
    temp_basket = cv2.pyrUp(basketball_pyr[i])
    laplacian_basketball_pyramid.append(cv2.subtract(basketball_pyr[i - 1], temp_basket))

mask_pyr = []
for i in range(n):
    height = 100 * (2 ** i)
    width = 100 * (2 ** i)
    mask = np.zeros((height, width), dtype=np.float32)
    t = np.arange(0, 1, 1 / 40)
    tc = np.tile(t, (height, 1))
    mask[:, (width // 2) - 20: (width // 2) + 20] = tc
    mask[:, (width // 2) + 20:] = np.full((height, width - ((width // 2) + 20)), 1)
    mask_pyr.append(mask)

result = np.zeros((100, 100, 3), dtype=np.float32)
result[:, :, 0] = mask_pyr[0] * laplacian_volleyball_pyramid[0][:, :, 0] + (1 - mask_pyr[0]) * \
                  laplacian_basketball_pyramid[0][:, :, 0]
result[:, :, 1] = mask_pyr[0] * laplacian_volleyball_pyramid[0][:, :, 1] + (1 - mask_pyr[0]) * \
                  laplacian_basketball_pyramid[0][:, :, 1]
result[:, :, 2] = mask_pyr[0] * laplacian_volleyball_pyramid[0][:, :, 2] + (1 - mask_pyr[0]) * \
                  laplacian_basketball_pyramid[0][:, :, 2]
result = result / np.amax(result)
result = result * 255
# cv2.imwrite('tem2p.jpg', result)

for i in range(1, n):
    result = cv2.pyrUp(result)
    result[:, :, 0] = result[:, :, 0] + mask_pyr[i] * laplacian_volleyball_pyramid[i][:, :, 0] + (
            1 - mask_pyr[i]) * laplacian_basketball_pyramid[i][:, :, 0]
    result[:, :, 1] = result[:, :, 1] + mask_pyr[i] * laplacian_volleyball_pyramid[i][:, :, 1] + (
            1 - mask_pyr[i]) * laplacian_basketball_pyramid[i][:, :, 1]
    result[:, :, 2] = result[:, :, 2] + mask_pyr[i] * laplacian_volleyball_pyramid[i][:, :, 2] + (
            1 - mask_pyr[i]) * laplacian_basketball_pyramid[i][:, :, 2]
    result = result / np.amax(result)
    result = result * 255

cv2.imwrite('res2.jpg', result)


