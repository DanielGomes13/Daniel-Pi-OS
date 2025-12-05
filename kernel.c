/* kernel.c - kernel mínimo x86_64 */
#include <stdint.h>

static unsigned short* VGA = (unsigned short*)0xB8000;
static int row = 0, col = 0;
static const int VGA_WIDTH = 80;

static void putchar(char c) {
    if (c == '\n') {
        col = 0;
        row++;
    } else {
        const uint8_t color = 0x0F; /* branco sobre preto */
        const unsigned short val = (unsigned short) c | (unsigned short) (color << 8);
        VGA[row * VGA_WIDTH + col] = val;
        col++;
        if (col >= VGA_WIDTH) { col = 0; row++; }
    }
    if (row >= 25) row = 0;
}

static void puts(const char* s) {
    while (*s) putchar(*s++);
}

void kernel_main(void) {
    puts("Daniel OS - kernel minimo\\n");
    puts("Versao: 0.1 Horizon\\n");
    puts("Pressione Ctrl+Alt+G para sair no QEMU (se estiver usando)\\n");
    for (;;) {
        asm volatile("hlt");
    }
}
