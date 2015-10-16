#include "OpenCLRunner.h"

OpenCLRunner::OpenCLRunner(
	std::string openCLPlatform,
	cl_device_type openCLDeviceType,
	bool useOpenCLBinary,
	std::string buildOptions,
	std::string sourceName,
	std::string binaryName
	) {

	program = ocl::buildProgramForDevice(
		openCLPlatform, openCLDeviceType, useOpenCLBinary,
		binaryName, sourceName, buildOptions,
		context, queue);
}

OpenCLRunner::~OpenCLRunner() {
	OCL_STATUS_INITIALIZE;
	OCL_CHECK(clReleaseProgram(program));
	OCL_CHECK(clReleaseCommandQueue(queue));
	OCL_CHECK(clReleaseContext(context));
}