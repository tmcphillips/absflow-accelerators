#pragma once
#include "CppUnitTest.h"
#include "nw_matrix.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace TestUtilities {

	class Utilities
	{
		public:

		static void AssertIsSane(nw_matrix_t* matrix);	

		static void AreEqual(int* expected, int** actual, int columns, int rows);
	
		static void AreEqual(char* expected, char* actual, bool ignoreCase = false, const wchar_t* message = NULL, const __LineInfo* pLineInfo = NULL)
		{
			Assert::AreEqual((const char*) expected, (const char*) actual, ignoreCase, message, pLineInfo);
		}

	};
}