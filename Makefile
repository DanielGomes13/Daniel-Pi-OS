# Makefile simples para compilar kernel ELF x86_64
TARGET = daniel-kernel.elf
SRCS = kernel.c
OBJS = $(SRCS:.c=.o)

CC = x86_64-elf-gcc
LD = x86_64-elf-ld
CFLAGS = -O2 -ffreestanding -nostdlib -fno-builtin -Wall -Wextra -mno-red-zone
LDFLAGS = -T linker.ld

all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): entry.S $(OBJS) linker.ld
	$(LD) $(LDFLAGS) entry.o $(OBJS) -o $(TARGET)

clean:
	rm -f *.o $(TARGET)
