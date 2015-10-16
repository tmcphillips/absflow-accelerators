#include "stdafx.h"
#include "CppUnitTest.h"

#include "opencl_utilities.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UtilitiesTests
{		
	TEST_CLASS(GetDeviceIdTests)
	{
	public:
		
		TEST_METHOD(TestGetDeviceId_IntelCpu)
		{
			auto id = ocl::get_device_id("Intel", CL_DEVICE_TYPE_CPU);
		}

		TEST_METHOD(TestGetDeviceId_NvidiaGpu)
		{
			auto id = ocl::get_device_id("NVIDIA", CL_DEVICE_TYPE_GPU);
		}


	};
}