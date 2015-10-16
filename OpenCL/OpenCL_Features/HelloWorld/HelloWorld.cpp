#include "opencl_utilities.h"
#include "HelloWorldConfig.h"
#include <iostream>

using std::string;
using std::cout;
using std::endl;

const int count = 20;

int main() {

	OCL_STATUS_INITIALIZE;

	std::string binaryName = "HelloWorld" + ocl::DeviceTraits<ProjectDevice>::BinaryExtension;
	cl_context context;
	cl_command_queue queue;
	cl_program program = ocl::buildProgramForDevice(
		ocl::DeviceTraits<ProjectDevice>::PlatformName,
		ocl::DeviceTraits<ProjectDevice>::DeviceType,
		ocl::DeviceTraits<ProjectDevice>::UseBinary,
		binaryName, "HelloWorld.cl", "", context, queue);

	size_t bufferSize = count * sizeof(char);
	cl_mem deviceOutput = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, bufferSize, nullptr, &OCL_STATUS));

	auto kernel = OCL_CHECK(clCreateKernel(program, "hello_kernel", &OCL_STATUS));
	OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_char*), &deviceOutput));
	size_t g[1] = { count };
	OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, g, nullptr, 0, nullptr, nullptr));

	char * buffer = new char[count];
	OCL_CHECK(clEnqueueReadBuffer(queue, deviceOutput, CL_TRUE, 0, bufferSize, buffer, 0, nullptr, nullptr));

	cout << buffer << std::endl;
	delete [] buffer;
}