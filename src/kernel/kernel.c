#include <stddef.h>
#include <stdint.h>
#include <kernel/uart.h>
#include <common/stdio.h>

void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags)
{
    (void)r0;
    (void)r1;
    (void)atags;

    uart_init();
    puts("Hello, kernel World!\r\n");

    char buf[100];

    while (1)
    {
        gets(&buf, 100);
        putc('\n');
    }
}