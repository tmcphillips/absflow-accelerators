#include "stdafx.h"
#include "PrimeSieve.h"

#include "PrimeSieveConfig.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using std::string;
using std::vector;

using SieveOfEratosthenes::PrimeSieve;
using SieveOfEratosthenes::lookupPrimesUpTo;

namespace SieveOfEratosthenesTests
{
	TEST_CLASS(CountPrimes_Tests)
	{

	public:

		TEST_METHOD(TestCountPrimesUpTo10)
		{
			PrimeSieve<cl_ushort> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			vector<int> lookedUp = lookupPrimesUpTo(10);
			size_t size = sieve.countPrimesUpTo(10);
			Assert::AreEqual(lookedUp.size(), size);
		}

		TEST_METHOD(TestCountPrimesUpTo14)
		{
			PrimeSieve<int> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			vector<int> lookedUp = lookupPrimesUpTo(14);
			size_t size = sieve.countPrimesUpTo(14);
			Assert::AreEqual(lookedUp.size(), size);
		}

		TEST_METHOD(TestCountPrimesUpTo100)
		{
			PrimeSieve<int> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			vector<int> lookedUp = lookupPrimesUpTo(100);
			size_t size = sieve.countPrimesUpTo(100);
			Assert::AreEqual(lookedUp.size(), size);
		}

		TEST_METHOD(TestCountPrimesUpTo1000)
		{
			PrimeSieve<int> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			size_t count = sieve.countPrimesUpTo(1000);
			Assert::AreEqual((size_t) 168, count);
		}

		TEST_METHOD(TestCountPrimesUpTo10000)
		{
			PrimeSieve<int> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			size_t count = sieve.countPrimesUpTo(10000);
			Assert::AreEqual((size_t) 1229, count);
		}

		TEST_METHOD(CountPrimesUpToOneMillion)
		{
			PrimeSieve<int> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			size_t count = sieve.countPrimesUpTo(1000000);
			Assert::AreEqual((size_t) 78498, count);
		}

		TEST_METHOD(CountPrimesUpToTenMillion)
		{
			PrimeSieve<cl_ulong> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			size_t count = sieve.countPrimesUpTo(10000000);
			Assert::AreEqual((size_t) 664579, count);
		}

		//TEST_METHOD(CountPrimesUpToOneHundredMillion)
		//{
		//	size_t count;
		//	countPrimesUpTo(100000000, &count);
		//	Assert::AreEqual((size_t) 5761455, count);
		//}

		//TEST_METHOD(CountPrimesUpToOneBillion)
		//{
		//	size_t count;
		//	countPrimesUpTo(1000000000, &count);
		//	Assert::AreEqual((size_t) 50847534, count);
		//}
	};
}