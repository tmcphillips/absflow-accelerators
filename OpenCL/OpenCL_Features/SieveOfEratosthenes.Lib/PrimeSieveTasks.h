#pragma once
#include "stdafx.h"
#include "PrimeSieve.h"
#include "PrimeSieveConfig.h"

using std::string;
using std::vector;

namespace SieveOfEratosthenes { namespace Tasks {

#ifdef ALTERAFPGA
	static bool const USE_OPENCL_BINARY = true;
#else
	static bool const USE_OPENCL_BINARY = false;
#endif


	template<bool enumerate = true>
	vector<cl_uint> findPrimesUpTo(cl_uint max, cl_uint* pPrimesCount) {

		OCL_STATUS_INITIALIZE;

		// access the desired platform and device
		cl_platform_id platform_id = ocl::get_platform_id(ocl::DeviceTraits<ProjectDevice>::PlatformName);
		cl_device_id device_id = ocl::get_device_id(platform_id, ocl::DeviceTraits<ProjectDevice>::DeviceType);

		// create a context and queue for the device
		cl_context context = OCL_CHECK(clCreateContext(nullptr, 1, &device_id, nullptr, nullptr, &OCL_STATUS));
		cl_command_queue queue = OCL_CHECK(clCreateCommandQueue(context, device_id, 0, &OCL_STATUS));

		// create the program from an opencl binary file or a source file
		cl_program program;
		if (USE_OPENCL_BINARY) {
			program = ocl::createProgramFromBinary(context, device_id,
				R"(D:\Accelerators\OpenCL\OpenCL_Features\ReverseComplement.Tests\altera\ReverseComplement.aocx)");
		}
		else {
			program = ocl::createProgramFromSource(context, "PrimeSieveTasks.cl");
		}

		// compile the opencl program and report errors
		OCL_CHECK_BUILD(clBuildProgram(program, 1, &device_id, "", nullptr, nullptr), program, device_id);

		// allocate buffer on device to hold primes
		size_t primesBufferSize = (max + 1) * sizeof(cl_uchar);
		cl_mem dPrimesBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, primesBufferSize, nullptr, &OCL_STATUS));

		// enqueue task for initialing primes buffer elements
		cl_kernel initializeAllIntegersKernel = OCL_CHECK(clCreateKernel(program, "initialize_all_integers", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(initializeAllIntegersKernel, 0, sizeof(cl_uint), &max));
		OCL_CHECK(clSetKernelArg(initializeAllIntegersKernel, 1, sizeof(cl_mem), &dPrimesBuffer));
		OCL_CHECK(clEnqueueTask(queue, initializeAllIntegersKernel, 0, nullptr, nullptr));

		// enqueue task for setting buffer elements coresponding to composite numbers to zero
		cl_kernel zeroAllCompositesKernel = OCL_CHECK(clCreateKernel(program, "zero_all_composites", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(zeroAllCompositesKernel, 0, sizeof(cl_uint), &max));
		OCL_CHECK(clSetKernelArg(zeroAllCompositesKernel, 1, sizeof(cl_mem), &dPrimesBuffer));
		OCL_CHECK(clEnqueueTask(queue, zeroAllCompositesKernel, 0, nullptr, nullptr));

		// create a vector for enumerating the primes if requested
		vector<cl_uint> * primes = new vector<cl_uint>();

		// enumerate or count primes
		if (enumerate) {

			// copy the primes buffer from the device to host memery
			auto hPrimesBuffer = new cl_uchar[max + 1];
			OCL_CHECK(clEnqueueReadBuffer(queue, dPrimesBuffer, CL_TRUE, 0, primesBufferSize, hPrimesBuffer, 0, nullptr, nullptr));

			// copy the primes to the vector
			for (cl_uint i = 2; i <= max; ++i) {
				if (hPrimesBuffer[i]) primes->push_back(i);
			}

			// return the number of primes via the return argument
			if (pPrimesCount != nullptr) *pPrimesCount = (cl_uint) primes->size();

		}
		else {

			// enqueue task for counting prime numbers on the device
			cl_kernel countAllPrimesKernel = OCL_CHECK(clCreateKernel(program, "count_all_primes", &OCL_STATUS));
			cl_mem dPrimesCount = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(cl_uint), nullptr, &OCL_STATUS));
			OCL_CHECK(clSetKernelArg(countAllPrimesKernel, 0, sizeof(cl_uint), &max));
			OCL_CHECK(clSetKernelArg(countAllPrimesKernel, 1, sizeof(cl_mem), &dPrimesBuffer));
			OCL_CHECK(clSetKernelArg(countAllPrimesKernel, 2, sizeof(cl_uint*), &dPrimesCount));
			OCL_CHECK(clEnqueueTask(queue, countAllPrimesKernel, 0, nullptr, nullptr));

			// return the number of primes via the return argument
			if (pPrimesCount != nullptr) {
				OCL_CHECK(clEnqueueReadBuffer(queue, dPrimesCount, CL_TRUE, 0, sizeof(cl_uint), pPrimesCount, 0, nullptr, nullptr));
			}

			// release OpenCL resources specific to this task
			OCL_CHECK(clReleaseKernel(countAllPrimesKernel));
			OCL_CHECK(clReleaseMemObject(dPrimesCount));
		}

		// release outstanding OpenCL resources
		OCL_CHECK(clReleaseKernel(initializeAllIntegersKernel));
		OCL_CHECK(clReleaseKernel(zeroAllCompositesKernel));
		OCL_CHECK(clReleaseMemObject(dPrimesBuffer));
		OCL_CHECK(clReleaseProgram(program));
		OCL_CHECK(clReleaseCommandQueue(queue));
		OCL_CHECK(clReleaseContext(context));

		// return vector of enumerated primes (empty if enumeration == false)
		return *primes;
	}
}}