#include "lib.h"

void *memcpy(void *dest, const void * src, size_t n)
{
    unsigned char *d, *s;
    d = (unsigned char*)dest;
    s = (unsigned char*)src;
    for (size_t i = 0; i < n; i++)
    {
        *d++ = *s++;
    }
    return dest;
}