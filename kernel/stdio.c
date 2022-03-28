#include "stdio.h"
#include "sbi.h"

void print(char *str) {
    while (*str) sbi_console_putchar(*str++);
}
