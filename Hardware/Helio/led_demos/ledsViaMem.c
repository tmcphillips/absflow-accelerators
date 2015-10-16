#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

#define MAP_SIZE 4096UL
#define MAP_MASK (MAP_SIZE - 1)

int main(int argc, char** argv) {

	int fd;
	void *map_base;
	void *virt_addr;
	off_t leds_physical_address = 0xFF210040;
	unsigned char state;

	fd = open("/dev/mem", O_RDWR | O_SYNC);
	map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
			fd, leds_physical_address  &~ MAP_MASK);
	virt_addr = map_base + (leds_physical_address & MAP_MASK);

	state = *((volatile unsigned char *)virt_addr);
	printf("LED state = %d\n", state);

	*((volatile unsigned char *)virt_addr) = 15;
	state = *((volatile unsigned char *)virt_addr);
	printf("LED state = %d\n", state);

	*((volatile unsigned char *)virt_addr) = 0;
	state = *((volatile unsigned char *)virt_addr);
	printf("LED state = %d\n", state);

	munmap(map_base, MAP_SIZE);
	close(fd);

	return 0;
}
