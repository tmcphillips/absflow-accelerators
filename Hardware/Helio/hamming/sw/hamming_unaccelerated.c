#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>

typedef unsigned long long uint64;

uint64 min(uint64 a, uint64 b) {
	return a <= b ? a : b;
}

size_t hamming(uint64 max, uint64* h) {
	size_t last_2 = 0;
	size_t last_3 = 0;
	size_t last_5 = 0;
	h[0] = 1;
	int i = 0;
	while (1) {
		uint64 next = min(min(2 * h[last_2], 3 * h[last_3]), 5 * h[last_5]);
		if (next > max) break;
		h[++i] = next;
		while (h[last_2] * 2 <= next) ++last_2;
		while (h[last_3] * 3 <= next) ++last_3;
		while (h[last_5] * 5 <= next) ++last_5;
	}
	return i + 1;
}

int main(int argc, char** argv) {

	uint64* h = malloc(2000 * sizeof(uint64));
	struct timespec start;
	struct timespec end;
	int i, j;
	long accumulatedMicroseconds = 0;

	for (j = 0; j < 10; ++j) {
		clock_gettime(CLOCK_REALTIME, &start);
		for (i = 0; i < 1000; ++i) {
			hamming(4271484375u, h);
		}
		clock_gettime(CLOCK_REALTIME, &end);
		long elapsedMicroseconds = (long)(end.tv_sec - start.tv_sec) * 1e6 +
									(end.tv_nsec - start.tv_nsec) / 1e3;
		printf("%f\n", elapsedMicroseconds/1.0e3);
		accumulatedMicroseconds += elapsedMicroseconds;
	}

	printf("Average: %f\n", accumulatedMicroseconds/10000.0);

	free(h);
	return 0;

}
