

CROSS_COMPILE := arm-linux-gnueabihf-
CC := $(CROSS_COMPILE)gcc
NM := $(CROSS_COMPILE)nm
RM := rm -rf

CFLAGS := -g -O0 -Wall

ELF := ledsViaDriver ledsViaMem

all: ledsViaDriver

clean:
	$(RM) $(ELF) *.o *.map

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

ledsViaDriver: ledsViaDriver.o
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
	$(NM) $@ > $@.map

ledsViaMem: ledsViaMem.o
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
	$(NM) $@ > $@.map
	