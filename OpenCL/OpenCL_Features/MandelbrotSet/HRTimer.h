#pragma once
#include "windows.h"

class HRTimer {

public:

	HRTimer() : clockPeriod(1.0/getFrequency()) {}
	
	double getFrequency() {
		LARGE_INTEGER proc_freq;
		::QueryPerformanceFrequency(&proc_freq);
		return static_cast<double>(proc_freq.QuadPart);
	}

	void start()
	{
		DWORD_PTR oldmask = ::SetThreadAffinityMask(::GetCurrentThread(), 0);
		::QueryPerformanceCounter(&startTime);
		::SetThreadAffinityMask(::GetCurrentThread(), oldmask);
	}

	double stop()
	{
		DWORD_PTR oldmask = ::SetThreadAffinityMask(::GetCurrentThread(), 0);
		::QueryPerformanceCounter(&stopTime);
		::SetThreadAffinityMask(::GetCurrentThread(), oldmask);
		return ((stopTime.QuadPart - startTime.QuadPart) * clockPeriod);
	}

private:

	LARGE_INTEGER startTime;
	LARGE_INTEGER stopTime;
	double clockPeriod;
};