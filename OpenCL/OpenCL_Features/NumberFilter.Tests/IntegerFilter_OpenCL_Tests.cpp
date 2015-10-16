#include "stdafx.h"
#include "CppUnitTest.h"
#include <string>
#include <vector>
#include "Utilities.h"
#include "NumberFilter.h"

using std::string;
using std::vector;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;
//using NumberFilter::OpenCL::NumberFilter;

namespace NumberFilterTests
{
	TEST_CLASS(IntegerFilter_OpenCL_Tests)
	{
	public:

		TEST_METHOD(TestLowpassFilter_OpenCL_Empty)
		{
			NumberFilter::OpenCL::NumberFilter<cl_int> nf(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary);
			vector<cl_int> inValues{ -42 };
			auto outValues = nf.lowpassFilter(inValues, 10);
			Assert::AreEqual(string(""), concatenate(outValues, ", "));
		}

		TEST_METHOD(TestLowpassFilter_OpenCL_ShorterThanFifo)
		{
			NumberFilter::OpenCL::NumberFilter<cl_int> nf(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary);
			vector<cl_int> inValues{ 10, 3, 5, -18, 16, 403, -19 };
			auto outValues = nf.lowpassFilter(inValues, 10);
			Assert::AreEqual(string("10, 3, 5, -18, -19"), concatenate(outValues, ", "));
		}

		TEST_METHOD(TestLowpassFilter_OpenCL_SameAsFifo)
		{
			NumberFilter::OpenCL::NumberFilter<cl_int> nf(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary);
			vector<cl_int> inValues{ 10, 3, 5, -18, 16, 403, -19, 10, 3, 5, -18, 16, 403, -19 };
			auto outValues = nf.lowpassFilter(inValues, 10);
			Assert::AreEqual(string("10, 3, 5, -18, -19, 10, 3, 5, -18, -19"), concatenate(outValues, ", "));
		}

		TEST_METHOD(TestLowpassFilter_OpenCL_LongerThanFifo)
		{
			NumberFilter::OpenCL::NumberFilter<cl_int> nf(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary);
			vector<cl_int> inValues{ 10, 3, 5, -18, 16, 403, -19, 10, 3, 5, -18, 16, 403, -19, 10, 3, 5, -18, 16, 403, -19 };
			auto outValues = nf.lowpassFilter(inValues, 10);
			Assert::AreEqual(string("10, 3, 5, -18, -19, 10, 3, 5, -18, -19, 10, 3, 5, -18, -19"), concatenate(outValues, ", "));
		}
	};
}