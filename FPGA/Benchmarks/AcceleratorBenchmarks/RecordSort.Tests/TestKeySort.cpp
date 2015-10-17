#include "stdafx.h"
#include "KeySort.h"
#include "DataGeneration.h"
#include "CppUnitTest.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace RecordSortTests
{
	using uint32 = unsigned int;

	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(TestQuickSort)
		{
			size_t size = 50000000;
			uint32* keys = new uint32[size];
			fillRandom<uint32>(keys, size);
			quicksort(keys, 0, size - 1);
		}
	};
}