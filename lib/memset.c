#include "lib.h"

void *memset(void *str, int c, size_t n) {
    unsigned char *s = (unsigned char*)str;
    for (size_t i = 0; i < n; i++)
    {
        *s++ = c;
    }
    return str;
}