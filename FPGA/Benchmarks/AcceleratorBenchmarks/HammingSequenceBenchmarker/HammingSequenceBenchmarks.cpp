#include "stdafx.h"

using namespace HammingSequence;

int _tmain(int argc, _TCHAR* argv[])
{
	uint64* h = new uint64[2000];
	
	HRTimer timer;
	double accumulatedTime = 0;

	for (int j = 0; j < 10; ++j) {
		timer.StartTimer();
		for (int i = 0; i < 100000; ++i) {
			hamming(4271484375u, h);
		}
		double elapsedTime = timer.StopTimer();
		accumulatedTime += elapsedTime;
		std::cout << elapsedTime << std::endl;
	}

	std::cout << "Average: " << accumulatedTime/10.0 << std::endl;

	delete[] h;
	return 0;
}

