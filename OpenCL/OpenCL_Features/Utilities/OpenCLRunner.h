#pragma once
#include "opencl_utilities.h"
#include <string>

class OpenCLRunner {

public:

	OpenCLRunner(
		std::string openCLPlatform, 
		cl_device_type openCLDeviceType, 
		bool useOpenCLBinary, 
		std::string buildOptions, 
		std::string sourceName, 
		std::string binaryName
	);

	virtual ~OpenCLRunner();

	template<ocl::OCLDeviceT ProjectDevice>
	static std::string getBuildOptions() {
		return	" -D DEVICE_TYPE=" + std::to_string(ocl::DeviceTraits<ProjectDevice>::DeviceType) +  
				" -D " + ocl::DeviceTraits<ProjectDevice>::PlatformName;
	}

protected:

	cl_context context;
	cl_command_queue queue;
	cl_program program;
};