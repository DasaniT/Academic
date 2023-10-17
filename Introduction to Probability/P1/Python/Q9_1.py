import matplotlib.pyplot as plt


def is_prime(n):
    if n == 1 or n == 0:
        return 0
    if n == 2:
        return 1
    for i in range(2, n):
        if n % i == 0:
            return 0
    return 1


def count_primes(n):
    count = 0
    for i in range(1, n + 1):
        if is_prime(i):
            count = count + 1
    return count


x = []  # n
y = []  # p_n
for j in range(2, 1001):
    x.append(j)
    y.append(count_primes(j) / j)
plt.plot(x, y)
plt.show()
