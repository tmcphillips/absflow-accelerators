#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>

typedef unsigned int uint32;


int main(int argc, char** argv) {

	int fd;
	uint32 cutoff = 4294967295u;
	int result;
	int i, j;
	size_t chunk_size = 2000;

	uint32* h = malloc(2000 * sizeof(uint32));
	uint32* ph;

	memset(h, 0, 2000 * sizeof(uint32));

	fd = open("/dev/hamming_driver", O_RDWR);

	struct timespec start;
	struct timespec end;
	long accumulatedMicroseconds = 0;

	for (j = 0; j < 10; ++j) {
		clock_gettime(CLOCK_REALTIME, &start);
		for (i = 0; i < 100; ++i) {
			memset(h, 0, 2000 * sizeof(uint32));
			ph = h;
			write(fd, &cutoff, 4);
			while (1) {
				result = read(fd, ph, chunk_size);
				if (result < 0) {
					printf("read returned %d", result);
					exit(1);
				}
				if (result == 0) break;
				ph += chunk_size;
			}
		}
		clock_gettime(CLOCK_REALTIME, &end);
		long elapsedMicroseconds = (long)(end.tv_sec - start.tv_sec) * 1e6 +
									(end.tv_nsec - start.tv_nsec) / 1e3;
		printf("%u\n", h[1847]);
		printf("%f\n", elapsedMicroseconds/1.0e2);
		accumulatedMicroseconds += elapsedMicroseconds;
	}



	printf("Average: %f\n", accumulatedMicroseconds/1000.0);

	close(fd);
	free(h);

	return 0;
}
