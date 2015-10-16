#include "PrimeSieve.h"
#include "PrimeSieveConfig.h"

using SieveOfEratosthenes::PrimeSieve;

int main() {

#ifdef ALTERAFPGA
	static bool const USE_OPENCL_BINARY = true;
#else
	static bool const USE_OPENCL_BINARY = false;
#endif

	PrimeSieve<cl_uint> sieve{ ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, USE_OPENCL_BINARY };
	auto computed = sieve.enumeratePrimesUpTo(50000000);
	exit(0);
}