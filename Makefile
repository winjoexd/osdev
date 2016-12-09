# editor by win

CROSS_COMPILE = i686-elf-
AR = $(CROSS_COMPILE)ar
AS = $(CROSS_COMPILE)as
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
CPP = $(CROSS_COMPILE)cpp
STRIP = $(CROSS_COMPILE)strip

CFLAGS += -std=gnu99 -ffreestanding -O2 -Wall -Wextra

BIN = winos.bin

OBJS = kernel.o

all: $(BIN)

boot.o: boot.s
	$(AS) $^ -o $@

winos.bin: boot.o $(OBJS)
	$(CC) -T linker.ld -o $@ -ffreestanding -O2 -nostdlib -lgcc $^

clean:
	rm -f *.o
	rm -f $(BIN)

run: $(BIN)
	qemu-system-i386 -kernel $(BIN)

# Implicit rules
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<


