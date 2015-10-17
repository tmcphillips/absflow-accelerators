#include "stdafx.h"
#include "CppUnitTest.h"
#include "array_utilities.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UtilitiesNativeTests
{		
	TEST_CLASS(Test_ArrayUtilities)
	{
	public:
		
		TEST_METHOD(TestLocateMaxValue)
		{
			int maxI, maxJ;
			matrix_t* matrix = matrix_create(3,3);
			matrix_initialize(matrix, 0);
			matrix->cell[1][2] = 5;
			int maxValue = matrix_locate_max_value(matrix, &maxI, &maxJ);

			Assert::AreEqual(1, maxI);
			Assert::AreEqual(2, maxJ);
			Assert::AreEqual(5, maxValue);
		}

	};
}