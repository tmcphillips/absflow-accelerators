#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char** argv) {

	int fd;
	int rc = 0;
	char ledState = 255;

	printf("Hello SoC FPGA!\n");

	fd = open("/dev/led_driver", O_RDWR);

	rc = read(fd, &ledState, 1);
	printf("Read %d bytes\t LED state = %d\n", rc, ledState);

	ledState = 15;
	rc = write(fd, &ledState, 1);
	printf("Wrote %d bytes\n", rc);

	rc = read(fd, &ledState, 1);
	printf("Read %d bytes\t LED state = %d\n", rc, ledState);

	ledState = 0;
	rc = write(fd, &ledState, 1);
	printf("Wrote %d bytes\n", rc);

	rc = read(fd, &ledState, 1);
	printf("Read %d bytes\t LED state = %d\n", rc, ledState);

	close(fd);

	return 0;
}
