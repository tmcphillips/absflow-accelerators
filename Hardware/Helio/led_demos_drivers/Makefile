


CROSS_COMPILE := arm-linux-gnueabihf-
KERNEL_SRC := ~/yocto/build/tmp/work/socfpga_cyclone5-poky-linux-gnueabi/linux-altera-3.7-r1/linux-altera-3.7
NM := $(CROSS_COMPILE)nm
RM := rm -rf
HELIO_EXEC := ssh root@helio
DEVICE_MAJOR := 234

KO := led_driver.ko

obj-$(CONFIG_ACCELERATORS) += led_driver.o

all: $(KO)

clean:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_SRC) M=$(PWD) clean

led_driver.ko: led_driver.c
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_SRC) M=$(PWD) modules
	$(NM) $@ > $@.map

install: led_driver.ko
	scp led_driver.ko root@helio:/home/root/
	
enable:
	$(HELIO_EXEC) rm -f /dev/led_driver
	$(HELIO_EXEC) mknod /dev/led_driver c $(DEVICE_MAJOR) 0
	$(HELIO_EXEC) insmod led_driver.ko
	
disable:
	$(HELIO_EXEC) rmmod led_driver
	$(HELIO_EXEC) rm -f /dev/led_driver