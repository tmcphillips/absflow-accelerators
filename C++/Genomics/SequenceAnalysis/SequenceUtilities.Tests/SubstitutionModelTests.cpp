#include "stdafx.h"
#include "CppUnitTest.h"
#include "AlignmentModel.h"

#include <vector>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using std::vector;

namespace SequenceUtilitiesTests
{
	TEST_CLASS(AlignmentModelTests)
	{
	public:
		
		TEST_METHOD(Test_CreateSubstitionModel_AdHoc) {

			vector<char> alphabet{ 'A', 'T', 'C', 'G' };

			vector<int> scores = {
				1, 2, 3, 4,
				5, 6, 7, 8,
				9, 10, 11, 12,
				13, 14, 15, 15
			};

			AlignmentModel sm{ alphabet, scores };
			Assert::AreEqual(6, sm.score('T', 'T'));
			Assert::AreEqual(5, sm.score('T', 'A'));
		}

	};
}