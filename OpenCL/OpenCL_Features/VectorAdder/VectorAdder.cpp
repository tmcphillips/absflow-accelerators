#include "opencl_utilities.h"
#include "single_device_context.h"
#include "VectorAdderConfig.h"

#include "CL/opencl.h"
#include <iostream>

using std::string;
using std::cout;
using std::endl;

const int count = 20000;

int main() {

	int hostA[count];
	int hostB[count];

	for (auto i = 0; i < count; ++i) {
		hostA[i] = i;
		hostB[i] = i * i;
	}

	string programSource = ocl::read_opencl_source("VectorAdder.cl");

	size_t bufferSize = count * sizeof(int);
	SingleDeviceContext sdc(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType);
	auto kernel = sdc.addKernel(programSource.c_str(), "add_vectors");
	cl_mem deviceA = sdc.createKernelInputBuffer(kernel, 0, bufferSize);
	cl_mem deviceB = sdc.createKernelInputBuffer(kernel, 1, bufferSize);
	cl_mem deviceC = sdc.createKernelOutputBuffer(kernel, 2, bufferSize);

	sdc.writeBuffer(deviceA, hostA);
	sdc.writeBuffer(deviceB, hostB);

	sdc.runKernel(kernel, count);

	int* hostC = (int*) sdc.readOutput(deviceC);

	for (auto i = count - 10; i < count; ++i) {
		cout << hostC[i] << std::endl;
	}
}