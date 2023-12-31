# unsigned int lfsr[16] = {0};
lfsr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
# The Rijndael S-box Sr
sr = [0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76
    , 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0
    , 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15
    , 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75
    , 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84
    , 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf
    , 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8
    , 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2
    , 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73
    , 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb
    , 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79
    , 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08
    , 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a
    , 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e
    , 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf
    , 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16]

# The S-Box Sq
sq = [0x25, 0x24, 0x73, 0x67, 0xD7, 0xAE, 0x5C, 0x30, 0xA4, 0xEE, 0x6E, 0xCB, 0x7D, 0xB5, 0x82, 0xDB,
      0xE4, 0x8E, 0x48, 0x49, 0x4F, 0x5D, 0x6A, 0x78, 0x70, 0x88, 0xE8, 0x5F, 0x5E, 0x84, 0x65, 0xE2,
      0xD8, 0xE9, 0xCC, 0xED, 0x40, 0x2F, 0x11, 0x28, 0x57, 0xD2, 0xAC, 0xE3, 0x4A, 0x15, 0x1B, 0xB9,
      0xB2, 0x80, 0x85, 0xA6, 0x2E, 0x02, 0x47, 0x29, 0x07, 0x4B, 0x0E, 0xC1, 0x51, 0xAA, 0x89, 0xD4,
      0xCA, 0x01, 0x46, 0xB3, 0xEF, 0xDD, 0x44, 0x7B, 0xC2, 0x7F, 0xBE, 0xC3, 0x9F, 0x20, 0x4C, 0x64,
      0x83, 0xA2, 0x68, 0x42, 0x13, 0xB4, 0x41, 0xCD, 0xBA, 0xC6, 0xBB, 0x6D, 0x4D, 0x71, 0x21, 0xF4,
      0x8D, 0xB0, 0xE5, 0x93, 0xFE, 0x8F, 0xE6, 0xCF, 0x43, 0x45, 0x31, 0x22, 0x37, 0x36, 0x96, 0xFA,
      0xBC, 0x0F, 0x08, 0x52, 0x1D, 0x55, 0x1A, 0xC5, 0x4E, 0x23, 0x69, 0x7A, 0x92, 0xFF, 0x5B, 0x5A,
      0xEB, 0x9A, 0x1C, 0xA9, 0xD1, 0x7E, 0x0D, 0xFC, 0x50, 0x8A, 0xB6, 0x62, 0xF5, 0x0A, 0xF8, 0xDC,
      0x03, 0x3C, 0x0C, 0x39, 0xF1, 0xB8, 0xF3, 0x3D, 0xF2, 0xD5, 0x97, 0x66, 0x81, 0x32, 0xA0, 0x00,
      0x06, 0xCE, 0xF6, 0xEA, 0xB7, 0x17, 0xF7, 0x8C, 0x79, 0xD6, 0xA7, 0xBF, 0x8B, 0x3F, 0x1F, 0x53,
      0x63, 0x75, 0x35, 0x2C, 0x60, 0xFD, 0x27, 0xD3, 0x94, 0xA5, 0x7C, 0xA1, 0x05, 0x58, 0x2D, 0xBD,
      0xD9, 0xC7, 0xAF, 0x6B, 0x54, 0x0B, 0xE0, 0x38, 0x04, 0xC8, 0x9D, 0xE7, 0x14, 0xB1, 0x87, 0x9C,
      0xDF, 0x6F, 0xF9, 0xDA, 0x2A, 0xC4, 0x59, 0x16, 0x74, 0x91, 0xAB, 0x26, 0x61, 0x76, 0x34, 0x2B,
      0xAD, 0x99, 0xFB, 0x72, 0xEC, 0x33, 0x12, 0xDE, 0x98, 0x3B, 0xC0, 0x9B, 0x3E, 0x18, 0x10, 0x3A,
      0x56, 0xE1, 0x77, 0xC9, 0x1E, 0x9E, 0x95, 0xA3, 0x90, 0x19, 0xA8, 0x6C, 0x09, 0xD0, 0xF0, 0x86]
r1 = 0
r2 = 0
r3 = 0


def mulX(v, c):
    if v & 0x80:
        return (v << 1) ^ c
    else:
        return v << 1


def mulY(v, i, c):
    if i < 0:
        return
    if i == 0:
        return v & 0xFF
    else:
        return mulX(mulY(v, i - 1, c), c) & 0xFF


def s1(w):
    w0 = (w >> 24) & 0xFF
    w1 = (w >> 16) & 0xFF
    w2 = (w >> 8) & 0xFF
    w3 = w & 0xFF

    p0 = (mulX(sr[w0], 0x1B) ^ sr[w1] ^ sr[w2] ^ (mulX(sr[w3], 0x1B) ^ sr[w3]))
    p1 = ((mulX(sr[w0], 0x1B) ^ sr[w0]) ^ mulX(sr[w1], 0x1B) ^ sr[w2] ^ sr[w3])
    p2 = (sr[w0] ^ (mulX(sr[w1], 0x1B) ^ sr[w1]) ^ mulX(sr[w2], 0x1B) ^ sr[w3])
    p3 = (sr[w0] ^ sr[w1] ^ (mulX(sr[w2], 0x1B) ^ sr[w2]) ^ mulX(sr[w3], 0x1B))

    return (p0 << 24) | (p1 << 16) | (p2 << 8) | p3


def s2(w):
    w0 = (w >> 24) & 0xFF
    w1 = (w >> 16) & 0xFF
    w2 = (w >> 8) & 0xFF
    w3 = (w & 0xFF)

    p0 = (mulX(sq[w0], 0x69) ^ sq[w1] ^ sq[w2] ^ (mulX(sq[w3], 0x69) ^ sq[w3]))
    p1 = ((mulX(sq[w0], 0x69) ^ sq[w0]) ^ mulX(sq[w1], 0x69) ^ sq[w2] ^ sq[w3])
    p2 = (sq[w0] ^ (mulX(sq[w1], 0x69) ^ sq[w1]) ^ mulX(sq[w2], 0x69) ^ sq[w3])
    p3 = (sq[w0] ^ sq[w1] ^ (mulX(sq[w2], 0x69) ^ sq[w2]) ^ mulX(sq[w3], 0x69))

    return (p0 << 24) | (p1 << 16) | (p2 << 8) | p3


def fsm():
    global r1
    global r2
    global r3
    F = ((lfsr[15] + r1) & 0xFFFFFFFF) ^ r2
    r = (r2 + (r3 ^ lfsr[5])) & 0xFFFFFFFF
    r3 = s2(r2)
    r2 = s1(r1)
    r1 = r
    return F


def mul(c):
    return (mulY(c, 23, 0xA9) << 24) | (mulY(c, 245, 0xA9) << 16) | (mulY(c, 48, 0xA9) << 8) | mulY(c, 239, 0xA9)


def div(c):
    return (mulY(c, 16, 0xA9) << 24) | (mulY(c, 39, 0xA9) << 16) | (mulY(c, 6, 0xA9) << 8) | mulY(c, 64, 0xA9)


def clock_lfsr(mode, F):
    s00 = (lfsr[0] >> (8 * 3)) & 0xFF
    s01 = (lfsr[0] >> (8 * 2)) & 0xFF
    s02 = (lfsr[0] >> 8) & 0xFF
    s03 = (lfsr[0] & 0xFF)
    s110 = (lfsr[11] >> (8 * 3)) & 0xFF
    s111 = (lfsr[11] >> (8 * 2)) & 0xFF
    s112 = (lfsr[11] >> 8) & 0xFF
    s113 = (lfsr[11] & 0xFF)
    v = 0

    if mode == 'i':
        v = (((s01 << 24) | (s02 << 16) | (s03 << 8) | 0x00) ^ mul(s00) ^ lfsr[2] ^ (
                (0x00 << 24) | (s110 << 16) | (s111 << 8) | s112) ^ div(s113) ^ F)
    elif mode == 'k':
        v = (((s01 << 24) | (s02 << 16) | (s03 << 8) | 0x00) ^ mul(s00) ^ lfsr[2] ^ (
                (0x00 << 24) | (s110 << 16) | (s111 << 8) | s112) ^ div(s113))
    for i in range(0, 15):
        lfsr[i] = lfsr[i + 1]
    lfsr[15] = v


def q3():
    number = int(input())
    number = number + 1
    print(number)
    return


n = 313

key = 0b00000000000000000000000000000000000000000000000000000000010100110110010101111001011001010110010000100000010000010110110001101001
iv = 0b00000000000000000000000000000000010001010110110101100001011001000110100100100000010101100110000101101100011010010110101101101001

k0 = 0b00100000010000010110110001101001
k1 = 0b01100101011110010110010101100100
k2 = 0b00000000000000000000000001010011
k3 = 0b00000000000000000000000000000000

iv0 = 0b01101100011010010110101101101001
iv1 = 0b01101001001000000101011001100001
iv2 = 0b01000101011011010110000101100100
iv3 = 0b00000000000000000000000000000000

one = 0xffffffff

lfsr[15] = k3 ^ iv0
lfsr[14] = k2
lfsr[13] = k1
lfsr[12] = k0 ^ iv1
lfsr[11] = k3 ^ one
lfsr[10] = k2 ^ one ^ iv2
lfsr[9] = k1 ^ one ^ iv3
lfsr[8] = k0 ^ one
lfsr[7] = k3
lfsr[6] = k2
lfsr[5] = k1
lfsr[4] = k0
lfsr[3] = k3 ^ one
lfsr[2] = k2 ^ one
lfsr[1] = k1 ^ one
lfsr[0] = k0 ^ one

for i in range(0, 32):
    clock_lfsr('i', fsm())
fsm()
clock_lfsr('k', 0)
keyStream = []
for i in range(0, n):
    f = fsm() ^ lfsr[0]
    keyStream.append(f)
    clock_lfsr('k', 0)
out = "0"

for i in range(0, len(keyStream)):
    # print(bin(keyStream[i])[2:])
    out = out + bin(keyStream[i])[2:]
x = "0"
v_0 = 0
for i in range(0, len(out)):
    if out[i] == x:
        v_0 = v_0 + 1
x = "1"
v_1 = 0
for i in range(0, len(out)):
    if out[i] == x:
        v_1 = v_1 + 1
x = "00"
v_00 = 0
for i in range(0, len(out) - 1):
    if out[i:i + 2] == x:
        v_00 = v_00 + 1
x = "01"
v_01 = 0
for i in range(0, len(out) - 1):
    if out[i:i + 2] == x:
        v_01 = v_01 + 1
x = "10"
v_10 = 0
for i in range(0, len(out) - 1):
    if out[i:i + 2] == x:
        v_10 = v_10 + 1
x = "11"
v_11 = 0
for i in range(0, len(out) - 1):
    if out[i:i + 2] == x:
        v_11 = v_11 + 1
x = "000"
v_000 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_000 = v_000 + 1
x = "001"
v_001 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_001 = v_001 + 1
x = "010"
v_010 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_010 = v_010 + 1
x = "011"
v_011 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_011 = v_011 + 1

x = "100"
v_100 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_100 = v_100 + 1

x = "101"
v_101 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_101 = v_101 + 1

x = "110"
v_110 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_110 = v_110 + 1
x = "111"
v_111 = 0
for i in range(0, len(out) - 2):
    if out[i:i + 3] == x:
        v_111 = v_111 + 1
x = "0000"
v_0000 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0000 = v_0000 + 1
x = "0001"
v_0001 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0001 = v_0001 + 1
x = "0010"
v_0010 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0010 = v_0010 + 1
x = "0011"
v_0011 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0011 = v_0011 + 1

x = "0100"
v_0100 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0100 = v_0100 + 1

x = "0101"
v_0101 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0101 = v_0101 + 1

x = "0110"
v_0110 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0110 = v_0110 + 1
x = "0111"
v_0111 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_0111 = v_0111 + 1
x = "1000"
v_1000 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1000 = v_1000 + 1
x = "1001"
v_1001 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1001 = v_1001 + 1
x = "1010"
v_1010 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1010 = v_1010 + 1
x = "1011"
v_1011 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1011 = v_1011 + 1

x = "1100"
v_1100 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1100 = v_1100 + 1

x = "1101"
v_1101 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1101 = v_1101 + 1

x = "1110"
v_1110 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1110 = v_1110 + 1
x = "1111"
v_1111 = 0
for i in range(0, len(out) - 3):
    if out[i:i + 4] == x:
        v_1111 = v_1111 + 1

x = "00000"
v_00000 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00000 = v_00000 + 1
x = "00001"
v_00001 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00001 = v_00001 + 1
x = "00010"
v_00010 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00010 = v_00010 + 1
x = "00011"
v_00011 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00011 = v_00011 + 1

x = "00100"
v_00100 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00100 = v_00100 + 1

x = "00101"
v_00101 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00101 = v_00101 + 1

x = "00110"
v_00110 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00110 = v_00110 + 1
x = "00111"
v_00111 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_00111 = v_00111 + 1
x = "01000"
v_01000 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01000 = v_01000 + 1
x = "01001"
v_01001 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01001 = v_01001 + 1
x = "01010"
v_01010 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01010 = v_01010 + 1
x = "01011"
v_01011 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01011 = v_01011 + 1

x = "01100"
v_01100 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01100 = v_01100 + 1

x = "01101"
v_01101 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01101 = v_01101 + 1

x = "01110"
v_01110 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01110 = v_01110 + 1
x = "01111"
v_01111 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_01111 = v_01111 + 1

x = "10000"
v_10000 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10000 = v_10000 + 1
x = "10001"
v_10001 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10001 = v_10001 + 1
x = "10010"
v_10010 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10010 = v_10010 + 1
x = "10011"
v_10011 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10011 = v_10011 + 1

x = "10100"
v_10100 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10100 = v_10100 + 1

x = "10101"
v_10101 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10101 = v_10101 + 1

x = "10110"
v_10110 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10110 = v_10110 + 1
x = "10111"
v_10111 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_10111 = v_10111 + 1
x = "11000"
v_11000 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11000 = v_11000 + 1
x = "11001"
v_11001 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11001 = v_11001 + 1
x = "11010"
v_11010 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11010 = v_11010 + 1
x = "11011"
v_11011 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11011 = v_11011 + 1

x = "11100"
v_11100 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11100 = v_11100 + 1

x = "11101"
v_11101 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11101 = v_11101 + 1

x = "11110"
v_11110 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11110 = v_11110 + 1
x = "11111"
v_11111 = 0
for i in range(0, len(out) - 4):
    if out[i:i + 5] == x:
        v_11111 = v_11111 + 1
print("0 : " + str(v_0))
print("1 : " + str(v_1))
print("00 : " + str(v_00))
print("01 : " + str(v_01))
print("10 : " + str(v_10))
print("11 : " + str(v_11))
print("000 : " + str(v_000))
print("001 : " + str(v_001))
print("010 : " + str(v_010))
print("011 : " + str(v_011))
print("100 : " + str(v_100))
print("101 : " + str(v_101))
print("110 : " + str(v_110))
print("111 : " + str(v_111))
print("0000 : " + str(v_0000))
print("0001 : " + str(v_0001))
print("0010 : " + str(v_0010))
print("0011 : " + str(v_0011))
print("0100 : " + str(v_0100))
print("0101 : " + str(v_0101))
print("0110 : " + str(v_0110))
print("0111 : " + str(v_0111))
print("1000 : " + str(v_1000))
print("1001 : " + str(v_1001))
print("1010 : " + str(v_1010))
print("1011 : " + str(v_1011))
print("1100 : " + str(v_1100))
print("1101 : " + str(v_1101))
print("1110 : " + str(v_1110))
print("1111 : " + str(v_1111))
print("00000 : " + str(v_00000))
print("00001 : " + str(v_00001))
print("00010 : " + str(v_00010))
print("00011 : " + str(v_00011))
print("00100 : " + str(v_00100))
print("00101 : " + str(v_00101))
print("00110 : " + str(v_00110))
print("00111 : " + str(v_00111))
print("01000 : " + str(v_01000))
print("01001 : " + str(v_01001))
print("01010 : " + str(v_01010))
print("01011 : " + str(v_01011))
print("01100 : " + str(v_01100))
print("01101 : " + str(v_01101))
print("01110 : " + str(v_01110))
print("01111 : " + str(v_01111))
print("10000 : " + str(v_10000))
print("10001 : " + str(v_10001))
print("10010 : " + str(v_10010))
print("10011 : " + str(v_10011))
print("10100 : " + str(v_10100))
print("10101 : " + str(v_10101))
print("10110 : " + str(v_10110))
print("10111 : " + str(v_10111))
print("11000 : " + str(v_11000))
print("11001 : " + str(v_11001))
print("11010 : " + str(v_11010))
print("11011 : " + str(v_11011))
print("11100 : " + str(v_11100))
print("11101 : " + str(v_11101))
print("11110 : " + str(v_11110))
print("11111 : " + str(v_11111))
