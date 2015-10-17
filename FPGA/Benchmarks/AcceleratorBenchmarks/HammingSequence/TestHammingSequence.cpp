#include "stdafx.h"
#include "CppUnitTest.h"
#include "HammingSequence.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace HammingSequence
{
	TEST_CLASS(HammingSequence)
	{
	public:

		TEST_METHOD(TestHamming_30)
		{
			uint64* h = new uint64[2000];
			size_t count = hamming(30, h);
			delete[] h;
		}

		TEST_METHOD(TestHamming_675)
		{
			uint64* h = new uint64[2000];
			Assert::AreEqual(75u, hamming(675u, h));
			delete[] h;
		}

		TEST_METHOD(TestHamming_11250)
		{
			uint64* h = new uint64[2000];
			Assert::AreEqual(181u, hamming(11250u, h));
			delete[] h;
		}

		TEST_METHOD(TestHamming_576000)
		{
			uint64* h = new uint64[2000];
			Assert::AreEqual(454u, hamming(576000u, h));
			delete[] h;
		}

		TEST_METHOD(TestHamming_179159040)
		{
			uint64* h = new uint64[2000];
			Assert::AreEqual(1204u, hamming(179159040u, h));
			delete[] h;
		}

		TEST_METHOD(TestHamming_4271484375)
		{
			uint64* h = new uint64[2000];
			Assert::AreEqual(1848u, hamming(4271484375u, h));
			delete[] h;
		}
	};
}