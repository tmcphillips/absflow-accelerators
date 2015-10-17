#include "stdafx.h"

int _tmain(int argc, _TCHAR* argv[])
{
	using uint32 = unsigned int;

	HRTimer timer;
	double accumulatedTime = 0;
	size_t size = 50000000;
	uint32* keys = new uint32[size];

	for (int j = 0; j < 10; ++j) {
		fillRandom<uint32>(keys, size);
		timer.StartTimer();
		quicksort(keys, 0, size - 1);
		double elapsedTime = timer.StopTimer();
		accumulatedTime += elapsedTime;
		std::cout << elapsedTime << std::endl;
	}

	std::cout << "Average: " << accumulatedTime / 10.0 << std::endl;

	delete[] keys;
	return 0;
}

