#include "stdafx.h"
#include "CppUnitTest.h"
#include <string>
#include <vector>
#include "Utilities.h"

using std::string;
using std::vector;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace NumberFilterTests
{
	template<typename T>
	vector<T> lowpassFilter(vector<T> inValues, T maxValue) {
		vector<T> outValues;
		for (T value : inValues) {
			if (value <= maxValue) outValues.push_back(value);
		}
		return outValues;
	}

	TEST_CLASS(IntegerFilter_Native_Tests)
	{
	public:
		
		TEST_METHOD(TestLowpassFilter_Native_Short)
		{
			vector<int> inValues{ 10, 3, 5, -18, 16, 403, -19 };
			auto outValues = lowpassFilter(inValues, 10);
			Assert::AreEqual(string("10, 3, 5, -18, -19"), concatenate(outValues, ", "));
		}
	};
}