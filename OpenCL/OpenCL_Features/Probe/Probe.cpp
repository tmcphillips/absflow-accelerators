#include "opencl_utilities.h"

#include "CL/opencl.h"

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>

using std::string;
using std::vector;
using std::cout;
using std::endl;

const string dash_delimiter = "----------------------------------------------------------------------------------------------------------------------------------------------------------------";

int main() {

	OCL_STATUS_INITIALIZE;

	cl_uint numPlatforms=0;

	// get number of OpenCL platforms
	OCL_CHECK(clGetPlatformIDs(0, nullptr, &numPlatforms));
	cout << dash_delimiter << endl << endl;
	cout << std::left << std::setw(ocl::DEFAULT_LABEL_COLUMN_WIDTH) << "Number of platforms" << " = " << numPlatforms << endl;

	// get platform IDs
	cl_platform_id *platformIDs = new cl_platform_id[numPlatforms];
	OCL_CHECK(clGetPlatformIDs(numPlatforms, platformIDs, nullptr));

	// loop over platforms
	for (size_t i = 0; i < numPlatforms; ++i) {

		cout << endl;
		cout << dash_delimiter << endl << endl;
		cout << "Platform " << i << " (id=" << platformIDs[i] << ")" << endl;
		cout << endl;

		ocl::print_platform_info("CL_PLATFORM_NAME", platformIDs[i], CL_PLATFORM_NAME);
		ocl::print_platform_info("CL_PLATFORM_VENDOR", platformIDs[i], CL_PLATFORM_VENDOR);
		ocl::print_platform_info("CL_PLATFORM_VERSION", platformIDs[i], CL_PLATFORM_VERSION);
		ocl::print_platform_info("CL_PLATFORM_PROFILE ", platformIDs[i], CL_PLATFORM_PROFILE);

		// get number of devices for this platform
		cl_uint numDevices = 0;
		OCL_CHECK(clGetDeviceIDs(platformIDs[i], CL_DEVICE_TYPE_ALL, 0, nullptr, &numDevices));
		cout << std::left << std::setw(ocl::DEFAULT_LABEL_COLUMN_WIDTH) << "Number of devices" << " = " << numDevices << endl;

		cl_device_id *deviceIDs = new cl_device_id[numDevices];
		OCL_CHECK(clGetDeviceIDs(platformIDs[i], CL_DEVICE_TYPE_ALL, numDevices, deviceIDs, nullptr));

		for (size_t j = 0; j < numDevices; ++j) {

			cout << endl;

			ocl::print_device_info<string>("CL_DEVICE_NAME", deviceIDs[j], CL_DEVICE_NAME);
			ocl::print_device_info<string>("CL_DEVICE_VENDOR", deviceIDs[j], CL_DEVICE_VENDOR);
			ocl::print_device_info<string>("CL_DEVICE_VERSION", deviceIDs[j], CL_DEVICE_VERSION);
			ocl::print_device_info<string>("CL_DRIVER_VERSION", deviceIDs[j], CL_DRIVER_VERSION);
			ocl::print_device_info<bool>("CL_DEVICE_IMAGE_SUPPORT", deviceIDs[j], CL_DEVICE_IMAGE_SUPPORT, std::cout);
			ocl::print_device_info<bool>("CL_DEVICE_COMPILER_AVAILABLE", deviceIDs[j], CL_DEVICE_COMPILER_AVAILABLE, std::cout);
			ocl::print_device_info<cl_uint>("CL_DEVICE_MAX_COMPUTE_UNITS", deviceIDs[j], CL_DEVICE_MAX_COMPUTE_UNITS);
			ocl::print_device_info<bool>("CL_DEVICE_AVAILABLE", deviceIDs[j], CL_DEVICE_AVAILABLE, std::cout);
			ocl::print_device_info<ocl::ocl_device_t>("CL_DEVICE_TYPE", deviceIDs[j], CL_DEVICE_TYPE, std::cout);
			ocl::print_device_info<size_t,3>("CL_DEVICE_MAX_WORK_ITEM_SIZES", deviceIDs[j], CL_DEVICE_MAX_WORK_ITEM_SIZES);
			ocl::print_device_info<size_t>("CL_DEVICE_MAX_WORK_GROUP_SIZE", deviceIDs[j], CL_DEVICE_MAX_WORK_GROUP_SIZE);
			ocl::print_device_info<cl_ulong>("CL_DEVICE_GLOBAL_MEM_SIZE", deviceIDs[j], CL_DEVICE_GLOBAL_MEM_SIZE);
			ocl::print_device_info<cl_ulong>("CL_DEVICE_MAX_MEM_ALLOC_SIZE", deviceIDs[j], CL_DEVICE_MAX_MEM_ALLOC_SIZE);
			ocl::print_device_info<cl_ulong>("CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE", deviceIDs[j], CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE);
			ocl::print_device_info<cl_ulong>("CL_DEVICE_LOCAL_MEM_SIZE", deviceIDs[j], CL_DEVICE_LOCAL_MEM_SIZE);
			ocl::print_device_info<bool>("CL_DEVICE_HOST_UNIFIED_MEMORY", deviceIDs[j], CL_DEVICE_HOST_UNIFIED_MEMORY, std::cout);
			ocl::print_device_info<bool>("CL_DEVICE_ENDIAN_LITTLE", deviceIDs[j], CL_DEVICE_ENDIAN_LITTLE, std::cout);

			cout << endl;
		}

		delete [] deviceIDs;
	}

	delete [] platformIDs;

	exit(0);
}