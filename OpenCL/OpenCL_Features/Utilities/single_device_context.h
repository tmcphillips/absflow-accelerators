#pragma once
#include "stdafx.h"
#include <string>
#include <vector>
#include <map>
#include "CL\opencl.h"

class SingleDeviceContext {

private:
	cl_device_id device_id;
	cl_platform_id platform_id;
	cl_context context;
	cl_command_queue queue;
	std::map<cl_kernel, cl_program> programForKernel;
	std::map<cl_program, const char*> sourceForProgram;
	std::map<cl_mem, size_t> sizeForDeviceBuffer;
	std::map<cl_mem, void*> hostBufferForDeviceBuffer;
	std::map<cl_mem, bool> hostBufferProvided;

public:

	SingleDeviceContext(const std::string platform_name, cl_device_type device_type);
	~SingleDeviceContext();

	cl_device_id getDeviceId() { return device_id; }
	cl_platform_id getPlatformId() { return platform_id;  }
	cl_kernel addKernel(const char* source, const char* name, const char* options = nullptr);
	cl_kernel addKernel(const unsigned char* code, const size_t bytes, const char* kernelName, const char* options = nullptr);
	cl_mem createBuffer(size_t bytes, cl_mem_flags flags);
	cl_mem createKernelInputBuffer(cl_kernel kernel, cl_uint argIndex, size_t bytes, cl_mem_flags flags = CL_MEM_READ_ONLY);
	cl_mem createKernelOutputBuffer(cl_kernel kernel, cl_uint argIndex, size_t bytes, void * suppliedHostBuffer = nullptr, cl_mem_flags flags = CL_MEM_WRITE_ONLY);
	void setKernelArgument(cl_kernel kernel, cl_uint argIndex, size_t argSize, const void * argValue);
	void runKernel(cl_kernel kernel, size_t workItemCount);
	void runKernel(cl_kernel kernel, size_t workItemCountX, size_t workItemCountY);
	void writeBuffer(cl_mem deviceBuffer, const void* hostBuffer);
	void readBuffer(cl_mem deviceBuffer, void* hostBuffer);
	void* readOutput(cl_mem deviceBuffer);
	void finish();
};