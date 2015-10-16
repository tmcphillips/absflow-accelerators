#include "stdafx.h"
#include "PrimeSieveNative.h"

using std::vector;

using SieveOfEratosthenes::lookupPrimesUpTo;
using SieveOfEratosthenes::Native::findPrimesUpTo;
using SieveOfEratosthenes::Native::findPrimesUpTo_Odd;

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace SieveOfEratosthenesTests
{
	TEST_CLASS(SievePrimesNative_Tests)
	{

#ifdef ALTERAFPGA
		static bool const USE_OPENCL_BINARY = true;
#else
		static bool const USE_OPENCL_BINARY = false;
#endif

	public:

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo30)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(30);
			vector<int> computed = findPrimesUpTo<int>(30, &count);
			Assert::AreEqual(10, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo31)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(31);
			vector<int> computed = findPrimesUpTo<int>(31, &count);
			Assert::AreEqual(11, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo32)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(32);
			vector<int> computed = findPrimesUpTo<int>(32, &count);
			Assert::AreEqual(11, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo100)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(100);
			vector<int> computed = findPrimesUpTo<int>(100, &count);
			Assert::AreEqual(25, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo541)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(541);
			vector<int> computed = findPrimesUpTo<int>(541, &count);
			Assert::AreEqual(100, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpToFirst100)
		{
			for (int n = 3; n <= 541; ++n) {
				printResults(std::to_string(n));
				vector<int> lookedUp = lookupPrimesUpTo(n);
				vector<int> computed = findPrimesUpTo<int>(n);
				Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
			}
		}

		TEST_METHOD(CountPrimesUpToOneHundred)
		{
			int count;
			findPrimesUpTo<int, false >(100, &count);
			Assert::AreEqual(25, count);
		}
		
		TEST_METHOD(CountPrimesUpToOneThousand)
		{
			int count;
			findPrimesUpTo<int, false >(1000, &count);
			Assert::AreEqual(168, count);
		}

		TEST_METHOD(CountPrimesUpToOneMillion)
		{
			int count;
			findPrimesUpTo<int, false>(1000000, &count);
			Assert::AreEqual(78498, count);
		}

		TEST_METHOD(CountPrimesUpToTenMillion)
		{
			int count;
			findPrimesUpTo<int, false>(10000000, &count);
			Assert::AreEqual(664579, count);
		}

		//TEST_METHOD(CountPrimesUpToOneHundredMillion)
		//{
		//	int count;
		//	findPrimesUpTo<int, false>(100000000, &count);
		//	Assert::AreEqual(5761455, count);
		//}
		
		//TEST_METHOD(CountPrimesUpToOneBillion)
		//{
		//	int count;
		//	findPrimesUpTo<int, false>(1000000000, &count);
		//	Assert::AreEqual(50847534, count);
		//}

		//TEST_METHOD(CountPrimesUpToTenBillion)
		//{
		//	long long count;
		//	findPrimesUpTo<long long, false>(10000000000, &count);
		//	Assert::IsTrue(455052511LL == count);
		//}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo30_Odd)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(30);
			vector<int> computed = findPrimesUpTo_Odd<int>(30, &count);
			//Assert::AreEqual(10, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo31_Odd)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(31);
			vector<int> computed = findPrimesUpTo_Odd<int>(31, &count);
			Assert::AreEqual(11, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo32_Odd)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(32);
			vector<int> computed = findPrimesUpTo_Odd<int>(32, &count);
			Assert::AreEqual(11, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo100_Odd)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(100);
			vector<int> computed = findPrimesUpTo_Odd<int>(100, &count);
			//Assert::AreEqual(25, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo541_Odd)
		{
			int count;
			vector<int> lookedUp = lookupPrimesUpTo(541);
			vector<int> computed = findPrimesUpTo_Odd<int>(541, &count);
			Assert::AreEqual(100, count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpToFirst100_Odd)
		{
			for (int n = 3; n <= 541; ++n) {
				printResults(std::to_string(n));
				vector<int> lookedUp = lookupPrimesUpTo(n);
				vector<int> computed = findPrimesUpTo_Odd<int>(n);
				Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
			}
		}

		TEST_METHOD(CountPrimesUpToOneHundred_Odd)
		{
			int count;
			findPrimesUpTo_Odd<int, false >(100, &count);
			Assert::AreEqual(25, count);
		}

		TEST_METHOD(CountPrimesUpToOneMillion_Odd)
		{
			int count;
			findPrimesUpTo_Odd<int, false>(1000000, &count);
			Assert::AreEqual(78498, count);
		}

		TEST_METHOD(CountPrimesUpToTenMillion_Odd)
		{
			int count;
			findPrimesUpTo_Odd<int, false>(10000000, &count);
			Assert::AreEqual(664579, count);
		}

		TEST_METHOD(CountPrimesUpToOneHundredMillion_Odd)
		{
			int count;
			findPrimesUpTo_Odd<int, false>(100000000, &count);
			Assert::AreEqual(5761455, count);
		}

		//TEST_METHOD(CountPrimesUpToOneBillion_Odd)
		//{
		//	int count;
		//	findPrimesUpTo_Odd<int, false>(1000000000, &count);
		//	Assert::AreEqual(50847534, count);
		//}

		//TEST_METHOD(CountPrimesUpToTenBillion_Odd)
		//{
		//	long long count;
		//	findPrimesUpTo_Odd<long long, false>(10000000000, &count);
		//	Assert::IsTrue(455052511LL == count);
		//}

		//TEST_METHOD(CountPrimesUpToOneHundredBillion_Odd)
		//{
		//	long long count;
		//	findPrimesUpTo_Odd<long long, false>(100000000000LL, &count);
		//	Assert::IsTrue(4118054813LL == count);
		//}
	};
}