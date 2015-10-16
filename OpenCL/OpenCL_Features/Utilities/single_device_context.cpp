#include "stdafx.h"
#include "opencl_utilities.h"
#include "single_device_context.h"

using std::string;
using std::to_string;

SingleDeviceContext::SingleDeviceContext(const std::string platform_name, cl_device_type device_type) {
	cl_int status;
	platform_id = ocl::get_platform_id(platform_name);
	device_id = ocl::get_device_id(platform_id, device_type);
	context = clCreateContext(nullptr, 1, &device_id, nullptr, nullptr, &status);
	queue = clCreateCommandQueue(context, device_id, 0, &status);
}

SingleDeviceContext::~SingleDeviceContext() {

	// release all kernels
	for (auto kp : programForKernel) clReleaseKernel(kp.first);

	// release all programs
	for (auto ps : sourceForProgram) clReleaseProgram(ps.first);

	// release the command queue
	clReleaseCommandQueue(queue);

	// release the context
	clReleaseContext(context);

	// release all device buffers
	for (auto bs : sizeForDeviceBuffer) clReleaseMemObject(bs.first);

	// release all host buffers
	for (auto bs : hostBufferForDeviceBuffer) {
		if (!hostBufferProvided[bs.first]) {
			delete [] bs.second;
		}
	}
}


cl_kernel SingleDeviceContext::addKernel(const char* programSource, const char* kernelName, const char* options) {

	cl_int status;

	// create the program object and associate with the provided OpenCL source string
	auto program = clCreateProgramWithSource(
		context,			// create the program in this context
		1,					// use one source string
		&programSource,		// address of single-element array of pointers to source string 
		nullptr,			// the program source string is null terminated
		&status				// address of the status variable for reporting result of call
	);

	if (status != CL_SUCCESS) {
		throw std::runtime_error{ 
			"Error " + to_string(status) + " creating program object for kernel " + string(kernelName) 
		};
	}

	// compile the program from the source string for the single device in the context
	status = clBuildProgram(
		program,			// compile the program created from the provided source string
		1,					// compile for just the one device associated with this context
		&device_id,			// address of a single-element array of pointers to devices to compile for
		options,			// compile with the provide options string
		nullptr,			// provide no callback function
		nullptr				// provide no user data for callback function
	);

	if (status != CL_SUCCESS) {
		std::stringstream errorMessage;
		errorMessage << "Error " << status << " building OpenCL program for kernel " << kernelName << std::endl;
		size_t buildlogSize;
		clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, 0, nullptr, &buildlogSize);
		char* buildlog = new char[buildlogSize + 1];
		clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, buildlogSize + 1, buildlog, nullptr);
		errorMessage << buildlog << std::endl;
		delete [] buildlog;
		throw std::runtime_error{ errorMessage.str() };
	}

	auto kernel = clCreateKernel(program, kernelName, &status);
	programForKernel[kernel] = program;
	sourceForProgram[program] = programSource;
	return kernel;
}

cl_kernel SingleDeviceContext::addKernel(const unsigned char* code, const size_t bytes, const char* kernelName, const char* options) {
	cl_int status;

	cl_program program = clCreateProgramWithBinary(context, 1, &device_id, &bytes, &code, nullptr, &status);
	status = clBuildProgram(program, 1, &device_id, options, nullptr, nullptr);
	auto kernel = clCreateKernel(program, kernelName, &status);
	programForKernel[kernel] = program;
	return kernel;
}

cl_mem SingleDeviceContext::createBuffer(size_t bytes, cl_mem_flags flags) {
	cl_int status;
	cl_mem buffer = clCreateBuffer(context, flags, bytes, nullptr, &status);
	sizeForDeviceBuffer[buffer] = bytes;
	return buffer;
}

cl_mem SingleDeviceContext::createKernelInputBuffer(cl_kernel kernel, cl_uint argIndex, size_t bytes, cl_mem_flags flags) {
	cl_int status;
	cl_mem deviceBuffer = createBuffer(bytes, flags);
	status = clSetKernelArg(kernel, argIndex, sizeof(cl_mem), &deviceBuffer);
	return deviceBuffer;
}

cl_mem SingleDeviceContext::createKernelOutputBuffer(cl_kernel kernel, cl_uint argIndex, size_t bytes, void * hostBuffer, cl_mem_flags flags) {
	cl_int status;
	cl_mem deviceBuffer = createBuffer(bytes, flags);
	status = clSetKernelArg(kernel, argIndex, sizeof(cl_mem), &deviceBuffer);
	if (hostBuffer) {
		hostBufferProvided[deviceBuffer] = true;
	} else {
		hostBuffer = new char[bytes];
		hostBufferProvided[deviceBuffer] = false;
	}
	hostBufferForDeviceBuffer[deviceBuffer] = hostBuffer;
	return deviceBuffer;
}

void SingleDeviceContext::setKernelArgument(cl_kernel kernel, cl_uint argIndex, size_t argSize, const void * argValue) {
	cl_int status = clSetKernelArg(kernel, argIndex, argSize, argValue);
}

void SingleDeviceContext::runKernel(cl_kernel kernel, size_t workItemCount) {
	cl_int status;
	size_t globalWorkSize[1] = { workItemCount };
	status = clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr);
	clFinish(queue);
}

void SingleDeviceContext::runKernel(cl_kernel kernel, size_t workItemCountX, size_t workItemCountY) {
	cl_int status;
	size_t globalWorkSize[2] = { workItemCountX, workItemCountY };
	size_t localWorkSize[2] = { 16, 16 };
	status = clEnqueueNDRangeKernel(queue, kernel, 2, nullptr, globalWorkSize, localWorkSize, 0, nullptr, nullptr);
	clFinish(queue);
}

void SingleDeviceContext::writeBuffer(cl_mem deviceBuffer, const void* hostBuffer) {

	cl_int status = clEnqueueWriteBuffer(
		queue,								// use the single queue for the single device
		deviceBuffer,						// write to the provided device buffer
		CL_TRUE,							// perform a synchronous write
		0,									// start writing at beginning of buffer
		sizeForDeviceBuffer[deviceBuffer],	// the size of the buffer to write to
		hostBuffer,							// the address of the host-side buffer to copy from
		0,									// don't wait for any events
		nullptr,							// no list of events to wait for
		nullptr								// don't create an event for this operation
	);

	if (status != CL_SUCCESS) {
		string errorMessage = "OpenCL Error " + std::to_string(status);
		throw std::exception(errorMessage.c_str());
	}
}

void SingleDeviceContext::readBuffer(cl_mem deviceBuffer, void* hostBuffer) {
	clEnqueueReadBuffer(queue, deviceBuffer, CL_TRUE, 0, sizeForDeviceBuffer[deviceBuffer], hostBuffer, 0, nullptr, nullptr);
}

void* SingleDeviceContext::readOutput(cl_mem deviceBuffer) {
	void * hostBuffer = hostBufferForDeviceBuffer[deviceBuffer];
	cl_int status = clEnqueueReadBuffer(queue, deviceBuffer, CL_TRUE, 0, sizeForDeviceBuffer[deviceBuffer], hostBuffer, 0, nullptr, nullptr);
	return hostBuffer;
}

void SingleDeviceContext::finish() {
	cl_int status = clFinish(queue);

}