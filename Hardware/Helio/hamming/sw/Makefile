

CROSS_COMPILE := arm-linux-gnueabihf-
KERNEL_SRC := ~/yocto/build/tmp/work/socfpga_cyclone5-poky-linux-gnueabi/linux-altera-3.7-r1/linux-altera-3.7
NM := $(CROSS_COMPILE)nm
RM := rm -rf
HELIO_EXEC := ssh root@helio
DEVICE_MAJOR := 235
CC := $(CROSS_COMPILE)gcc
DEMO_CFLAGS := -g -O0 -Wall

ELF := hamming_demo hamming_unaccelerated
KO := hamming_driver.ko

.c.o:
	$(CC) $(DEMO_CFLAGS) -c $< -o $@

all: $(ELF) $(KO)

hamming_unaccelerated: hamming_unaccelerated.o
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS) -lrt
	$(NM) $@ > $@.map

hamming_demo: hamming_demo.o
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS) -lrt
	$(NM) $@ > $@.map

obj-$(CONFIG_ACCELERATORS) += hamming_driver.o

clean:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_SRC) M=$(PWD) clean
	$(RM) $(ELF) *.o *.map

hamming_driver.ko: hamming_driver.c
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_SRC) M=$(PWD) modules
	$(NM) $@ > $@.map

install: hamming_driver.ko
	scp hamming_driver.ko root@helio:/home/root/
	
enable:
	$(HELIO_EXEC) rm -f /dev/hamming_driver
	$(HELIO_EXEC) mknod /dev/hamming_driver c $(DEVICE_MAJOR) 0
	$(HELIO_EXEC) insmod hamming_driver.ko
	
disable:
	$(HELIO_EXEC) rmmod hamming_driver
	$(HELIO_EXEC) rm -f /dev/hammingdriver