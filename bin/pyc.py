import ctypes

cadd = ctypes.CDLL('./build/libcadd.so')

result = cadd.add(2, 2)
print('2 + 2 = %d' % result)