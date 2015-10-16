#include "stdafx.h"
#include "PrimeSieveTasks.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using std::string;
using std::vector;

using SieveOfEratosthenes::lookupPrimesUpTo;
using SieveOfEratosthenes::Tasks::findPrimesUpTo;

namespace SieveOfEratosthenesTests
{
	TEST_CLASS(SievePrimesTasks_Tests)
	{
	public:
		
		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo10)
		{
			cl_uint count;
			vector<int> lookedUp = lookupPrimesUpTo(10);
			vector<cl_uint> computed = findPrimesUpTo(10, &count);
			Assert::AreEqual((cl_uint)lookedUp.size(), count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo30)
		{
			cl_uint count;
			vector<int> lookedUp = lookupPrimesUpTo(30);
			vector<cl_uint> computed = findPrimesUpTo(30, &count);
			Assert::AreEqual((cl_uint) lookedUp.size(), count);
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo1000)
		{
			cl_uint count;
			vector<cl_uint> computed = findPrimesUpTo(1000, &count);
			Assert::AreEqual((cl_uint) 168, count);
		}

		TEST_METHOD(CountPrimesUpToOneMillion)
		{
			cl_uint count;
			findPrimesUpTo<false>(1000000, &count);
			Assert::AreEqual((cl_uint) 78498, count);
		}

		TEST_METHOD(CountPrimesUpToTenMillion)
		{
			cl_uint count;
			findPrimesUpTo<false>(10000000, &count);
			Assert::AreEqual((cl_uint) 664579, count);
		}

		//TEST_METHOD(CountPrimesUpToOneHundredMillion)
		//{
		//	cl_uint count;
		//	findPrimesUpTo<false>(100000000, &count);
		//	Assert::AreEqual((cl_uint) 5761455, count);
		//}

		//TEST_METHOD(CountPrimesUpToOneBillion)
		//{
		//	cl_uint count;
		//	findPrimesUpTo<false>(1000000000, &count);
		//	Assert::AreEqual((cl_uint) 50847534, count);
		//}
	};
}