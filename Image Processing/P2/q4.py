import cv2
import numpy as np


def gauss2D(shape, sigma):
    m = (shape[0] - 1.0) / 2
    n = (shape[1] - 1.0) / 2
    y, x = np.ogrid[-m:m + 1, -n:n + 1]
    h = np.exp(-(x ** 2 + y ** 2) / (2.0 * (sigma ** 2)))
    sumh = h.sum()
    h = h / sumh if sumh != 0 else h
    return h


ricciardo = cv2.imread('q4_02_far.jpg')
leclerc = cv2.imread('q4_01_near.jpg')

leclerc_log = np.log(np.abs(np.fft.fftshift(np.fft.fft2(leclerc))))
ricciardo_log = np.log(np.abs(np.fft.fftshift(np.fft.fft2(ricciardo))))

ricciardo_log = (ricciardo_log / np.amax(ricciardo_log)) * 255
leclerc_log = (leclerc_log / np.amax(leclerc_log)) * 255
cv2.imwrite('q4_06_dft_far.jpg', ricciardo_log)
cv2.imwrite('q4_05_dft_near.jpg', leclerc_log)

lowpass = []
highpass = []

gauss = gauss2D((1024, 1024), sigma=30)
# cutoff = 50

cv2.imwrite('Q4_08_lowpass_30.jpg', (gauss / np.amax(gauss)) * 255)
# gauss = gauss / np.amax(gauss)
gauss = np.fft.fft2(np.fft.ifftshift(gauss))

for i in range(3):
    ricciardo_fft = np.fft.fft2(ricciardo[:, :, i])
    test = ricciardo_fft * gauss
    lowpass.append(np.copy(test))

logg = np.log(np.abs(lowpass))
logg = (logg / np.amax(logg)) * 255
logg = np.uint8(logg)
logg = cv2.merge((logg[0], logg[1], logg[2]))
cv2.imwrite('Q4_12_lowpassed.jpg', logg)

gauss = gauss2D((1024, 1024), sigma=28)
temp = ((gauss) / np.amax(gauss))
cv2.imwrite('Q4_07_highpass_28.jpg', (1 - temp) * 255)

gauss = np.fft.fftshift(np.fft.fft2(gauss))
# temp = ((1 - gauss) / np.amax(1-gauss)) * 255
# cv2.imwrite('Q4_09_highpass_cutoff.jpg', np.log(np.abs(temp)))

for i in range(3):
    leclerc_fft = np.fft.fft2(leclerc[:, :, i])
    test = leclerc_fft * gauss
    test = leclerc_fft - test
    highpass.append(np.copy(test))

logg = np.log(np.abs(highpass))
logg = (logg / np.amax(logg)) * 255
logg = np.uint8(logg)
logg = cv2.merge((logg[0], logg[1], logg[2]))
cv2.imwrite('Q4_11_highpassed.jpg', logg)

hybrid = []
hybrid.append(0.85 * lowpass[0] + 0.15 * highpass[0])
hybrid.append(0.85 * lowpass[1] + 0.15 * highpass[1])
hybrid.append(0.85 * lowpass[2] + 0.15 * highpass[2])

logg = np.log(np.abs(hybrid))
logg = (logg / np.amax(logg)) * 255
logg = np.uint8(logg)
logg = cv2.merge((logg[0], logg[1], logg[2]))
cv2.imwrite('Q4_13_hybrid_frequency.jpg', logg)

blue = np.fft.ifft2(hybrid[0])
blue = np.real(blue)
green = np.fft.ifft2(hybrid[1])
green = np.real(green)
red = np.fft.ifft2(hybrid[2])
red = np.real(red)

hybrid = cv2.merge((blue, green, red))

cv2.imwrite('Q4_14_hybrid_near.jpg', hybrid)
hybrid = cv2.resize(hybrid, (32, 32))
cv2.imwrite('Q4_15_hybrid_far.jpg', hybrid)
