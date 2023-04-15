#include <stdint.h>

unsigned char inb(unsigned short int port) {
    unsigned char ret;
    __asm__ __volatile__("inb %1, %0" : "=a" (ret) : "Nd" (port));
    return ret;
}

void outb(uint16_t port, uint8_t val) {
    __asm__ __volatile__("outb %0, %1" : : "a" (val), "Nd" (port));
}