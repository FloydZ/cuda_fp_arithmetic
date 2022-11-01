#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import math
import random
import time
ceildiv = lambda x, y: -(-x//y)
int2str = lambda x,  string: string.format(x)

TESTS = (1 << 4)


def fe2str(x, p, arch=32, comma=True, lengthmult=1):
    # for 32-bit: 8
    s = arch//4
    length = lengthmult * ceildiv(p.bit_length(), s * 4) * s
    X = int2str(x, '{:0%dX}' % length)
    Y = [X[i:i+s] for i in range(0, length, s)]
    Y.reverse()
    if comma:
        return '{ 0x' + ', 0x'.join(Y) + ' },\n'
    return '{ 0x' + ', 0x'.join(Y) + ' }'


def xgcd(a, b):
    prevx, x = 1, 0
    prevy, y = 0, 1

    while b:
        q, r = divmod(a, b)
        x, prevx = prevx - q*x, x
        y, prevy = prevy - q*y, y
        a, b = b, r
    return a, prevx, prevy


def mont_params(p, nw, arch):
    r = (2**arch)**nw
    R = r % p
    neg_R = (-R) % p
    _, mu, _ = xgcd((-p) % r, r)
    mu = mu % r
    return mu, R, neg_R


def redc(c, mu, p, w, arch=32):
    m = (mu * c) % 2 ** (arch * w)
    u = m * p
    r = (c + u) // 2 ** (arch * w)
    if r >= p:
        return r - p
    return r


def gen_op(p, mu, arch=32):
    w = math.ceil(p.bit_length() / arch)
    elems_a = []
    elems_b = []

    # Variables
    str_a = '__constant__ limb_t a[TESTS][%d] = {\n' % w
    str_b = '__constant__ limb_t b[TESTS][%d] = {\n' % w
    str_mul = 'limb_t mul_fp_ok[TESTS][%d] = {\n' % w
    str_sqr = 'limb_t sqr_fp_ok[TESTS][%d] = {\n' % w
    str_add = 'limb_t add_fp_ok[TESTS][%d] = {\n' % w
    str_sub = 'limb_t sub_fp_ok[TESTS][%d] = {\n' % w
    str_mulfull = 'limb_t mul_ok[TESTS][%d] = {\n' % (2*w)
    str_sqrfull = 'limb_t sqr_ok[TESTS][%d] = {\n' % (2*w)
    # Basic operations

    for i in range(0, TESTS):
        elems_a.append(random.randint(1, p - 1))
        elems_b.append(random.randint(1, p - 1))
        str_a = str_a + fe2str(elems_a[i], p)
        str_b = str_b + fe2str(elems_b[i], p)

        # Multiplication
        str_mul = str_mul + fe2str(redc(elems_a[i] * elems_b[i], mu, p, w), p)
        # Square 
        str_sqr = str_sqr + fe2str(redc(elems_a[i] * elems_a[i], mu, p, w), p)
        # Addition
        str_add = str_add + fe2str((elems_a[i] + elems_b[i]) % p, p)
        # Subtraction
        str_sub = str_sub + fe2str((elems_a[i] - elems_b[i]) % p, p)
        # Multiplicaation without reduction
        str_mulfull = str_mulfull + fe2str(elems_a[i] * elems_b[i], p, arch, True, 2)
        # squaring without reduction
        str_sqrfull = str_sqrfull + fe2str(elems_a[i] * elems_a[i], p, arch, True, 2)

    str_a = str_a[0:len(str_a) - 2] + '};\n'
    str_b = str_b[0:len(str_b) - 2] + '};\n'
    str_add = str_add[0:len(str_add) - 2] + '};\n'
    str_sub = str_sub[0:len(str_sub) - 2] + '};\n'
    str_mul = str_mul[0:len(str_mul) - 2] + '};\n'
    str_sqr = str_sqr[0:len(str_sqr) - 2] + '};\n'
    str_mulfull = str_mulfull[0:len(str_mulfull) - 2] + '};\n'
    str_sqrfull = str_sqrfull[0:len(str_sqrfull) - 2] + '};\n'

    print(str_a)
    print(str_b)
    print(str_add)
    print(str_sub)
    print(str_mul)
    print(str_sqr)
    print(str_mulfull)
    print(str_sqrfull)


if __name__ == "__main__":
    time_ns = time.monotonic_ns()
    random.seed(time_ns)
    BITLENGTH = 32

    # the challenge parameters
    # 2 limbs
    # e2 = 24
    # e3 = 18
    # f = 21

    # 3 limbs
    # e2 = 32
    # e3 = 20
    # f = 23

    # 4 limbs
    e2 = 58
    e3 = 36
    f = 743

    # 5 limbs
    # e2 = 64
    # e3 = 43
    # f = 17

    # 6 limbs
    # e2 = 91
    # e3 = 57
    # f = 1

    # 7 limbs
    # e2 = 110
    # e3 = 67
    # f = 1

    # 8 limbs
    # e2 = 113
    # e3 = 83
    # f = 38

    p = 2**e2 * 3**e3 * f - 1
    w = math.ceil(p.bit_length() / BITLENGTH)
    bitlength = p.bit_length()
    mu, mont_one, mont_minus_one = mont_params(p, ceildiv(bitlength, BITLENGTH), BITLENGTH)

    print('#define TESTS %d\n' % (TESTS))
    print('#define LIMBS %d\n' % (w))
    print('#define limb_t uint%d_t\n' % (BITLENGTH))

    str_p = '__constant__ limb_t __p[%d] = ' % w
    str_mu = '__constant__ limb_t __mu[%d] = ' % w
    str_p += fe2str(p, p, BITLENGTH, False)
    str_mu += fe2str(mu, p, BITLENGTH, False)
    str_p += ";"
    str_mu += ";"
    print(str_p)
    print(str_mu)
    gen_op(p, mu)
