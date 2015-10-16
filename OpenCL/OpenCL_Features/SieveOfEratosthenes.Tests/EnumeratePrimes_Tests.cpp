#include "stdafx.h"
#include "PrimeSieve.h"
#include "PrimeSieveConfig.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using std::string;
using std::vector;

using SieveOfEratosthenes::lookupPrimesUpTo;
using SieveOfEratosthenes::PrimeSieve;

namespace SieveOfEratosthenesTests
{
	TEST_CLASS(EnumeratePrimes_Tests)
	{
	public:

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo10)
		{
			PrimeSieve<cl_ushort> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto lookedUp = lookupPrimesUpTo(10);
			auto computed = sieve.enumeratePrimesUpTo(10);
			Assert::AreEqual(lookedUp.size(), computed.size());
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo14)
		{
			PrimeSieve<cl_ushort> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto lookedUp = lookupPrimesUpTo(14);
			auto computed = sieve.enumeratePrimesUpTo(14);
			Assert::AreEqual(lookedUp.size(), computed.size());
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo30)
		{
			PrimeSieve<cl_ushort> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto lookedUp = lookupPrimesUpTo(30);
			auto computed = sieve.enumeratePrimesUpTo(30);
			Assert::AreEqual(lookedUp.size(), computed.size());
			Assert::AreEqual(concatenate(lookedUp), concatenate(computed));
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo1000)
		{
			PrimeSieve<cl_uint> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto computed = sieve.enumeratePrimesUpTo(1000);
			Assert::AreEqual((size_t) 168, computed.size());
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpTo10000)
		{
			PrimeSieve<cl_uint> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto computed = sieve.enumeratePrimesUpTo(10000);
			Assert::AreEqual((size_t) 1229, computed.size());
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpToOneMillion)
		{
			PrimeSieve<cl_uint> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto computed = sieve.enumeratePrimesUpTo(1000000);
			Assert::AreEqual((size_t) 78498, computed.size());
		}

		TEST_METHOD(TestEnumerateSequencesOfPrimesUpToTenMillion)
		{
			PrimeSieve<cl_ulong> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary };
			auto computed = sieve.enumeratePrimesUpTo(10000000);
			Assert::AreEqual((size_t) 664579, computed.size());
		}

		//TEST_METHOD(TestEnumerateSequencesOfPrimesUpToOneHundredMillion)
		//{
		//	autos computed = enumeratePrimesUpTo<cl_uint,cl_uint>(100000000);
		//	Assert::AreEqual((size_t) 5761455, computed.size());
		//}
	};
}