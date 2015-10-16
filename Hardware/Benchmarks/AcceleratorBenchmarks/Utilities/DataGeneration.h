#pragma once

template<typename T>
void fillRandom(T a[], size_t size, unsigned int seed = 0u) {
	srand(seed);
	for (size_t i = 0; i < size; ++i) {
		a[i] = rand() * rand();
	}
}