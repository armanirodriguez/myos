#ifndef H_PORTMAP
#define H_PORTMAP

#include <stdint.h>

unsigned char inb(unsigned short port);
void outb(uint16_t port, uint8_t val);

#endif