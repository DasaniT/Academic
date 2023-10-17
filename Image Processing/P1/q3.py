import cv2
import numpy as np

def lss(A, B):
    return np.sum((A - B) ** 2)


def estimate_v2(border, search_range, green, blue_or_red, start_row=0, start_column=0):
    green_w_border = cv2.copyMakeBorder(green, border, border, border, border, cv2.BORDER_CONSTANT)
    row, column = blue_or_red.shape
    minimum = 2 ** 63
    min_i = -1
    min_j = -1
    for i in range(border + (start_row * 2) - search_range , border + (start_row * 2) + search_range):
        for j in range(border + (start_column * 2) - search_range, border + (start_column * 2) + search_range):
            temp = green_w_border[i:i + row, j:j + column]
            ls = lss(temp, blue_or_red)
            tempp = np.abs(i - border) * np.abs(j - border)
            ls = ls - (tempp * (255 ** 2))
            if ls < minimum:
                minimum = ls
                min_i = i - border
                min_j = j - border
    return min_i, min_j

image = cv2.imread('./melons.tif', 0)
image_height = image.shape[0] // 3
image_width = image.shape[1]
blue = image[0:image_height]
green = image[image_height:image_height * 2]
red = image[image_height * 2:image_height * 3]
blue = (cv2.GaussianBlur(blue,(5,5),0)).astype(np.float64)
green = (cv2.GaussianBlur(green,(5,5),0)).astype(np.float64)
red = (cv2.GaussianBlur(red,(5,5),0)).astype(np.float64)

blue_pyramid= []
green_pyramid = []
red_pyramid = []
for i in range(5):
    blue_pyramid.append(cv2.resize(blue, (image_width // (2**i), image_height // (2 ** i) )))
    green_pyramid.append(cv2.resize(green, (image_width // (2**i), image_height // (2 ** i))))
    red_pyramid.append(cv2.resize(red, (image_width // (2**i), image_height // (2 ** i))))

i_blue = 0
j_blue = 0
i_red = 0
j_red = 0
search_range = 15
border = 15
for i in range(5):
    i_blue, j_blue = estimate_v2(border, search_range,green_pyramid[4-i], blue_pyramid[4-i], i_blue, j_blue)
    i_red, j_red = estimate_v2(border, search_range,green_pyramid[4-i], red_pyramid[4-i], i_red, j_red)
    border = border * 2
    search_range = 2


row, column = green_pyramid[0].shape
green = green_pyramid[0]
blue = blue_pyramid[0]
red = red_pyramid[0]

if i_blue < 0:
    blue = blue[-i_blue:row]
if i_blue > 0:
    blue = cv2.copyMakeBorder(blue, i_blue, 0, 0, 0, cv2.BORDER_CONSTANT)
if j_blue<0:
    blue = blue[:, -j_blue:column]
if j_blue > 0:
    blue = cv2.copyMakeBorder(blue, 0, 0, j_blue, 0, cv2.BORDER_CONSTANT)
if i_red < 0:
    red = red[-i_red:row]
if i_red > 0:
    red = cv2.copyMakeBorder(red, i_red, 0, 0, 0, cv2.BORDER_CONSTANT)
if j_red<0:
    red=red[:,-j_red:column]
if j_red>0:
    red = cv2.copyMakeBorder(red, 0, 0, j_red, 0, cv2.BORDER_CONSTANT)


# image resize
if red.shape[0] < image_height:
    red = cv2.copyMakeBorder(red, 0, image_height - red.shape[0], 0, 0, cv2.BORDER_CONSTANT)
if red.shape[0] > image_height:
    red = red[0:image_height]
if red.shape[1] < image_width:
    red = cv2.copyMakeBorder(red, 0, 0, 0, image_width - red.shape[1], cv2.BORDER_CONSTANT)
if red.shape[1] > image_width:
    red = red[:, 0:image_width]
if blue.shape[0] < image_height:
    blue = cv2.copyMakeBorder(blue, 0, image_height - blue.shape[0], 0, 0, cv2.BORDER_CONSTANT)
if blue.shape[0] > image_height:
    blue = blue[0:image_height]
if blue.shape[1] < image_width:
    blue = cv2.copyMakeBorder(blue, 0, 0, 0, image_width - blue.shape[1], cv2.BORDER_CONSTANT)
if blue.shape[1] > image_width:
    blue = blue[:, 0:image_width]


res = cv2.merge((blue,green,red))
cv2.imwrite('res04.jpg', res)
