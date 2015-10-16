#pragma once
#include "NumberFilterConfig.h"
#include "opencl_utilities.h"
#include "OpenCLRunner.h"
#include <string>
#include <vector>


namespace NumberFilter { namespace OpenCL {

	template<typename T>
	class NumberFilter : public OpenCLRunner
	{
	public:
		NumberFilter(std::string openCLPlatform, cl_device_type openCLDeviceType, bool useOpenCLBinary);
		~NumberFilter() {}
		std::vector<T> lowpassFilter(std::vector<T> inValues, T maxValue);
	private:
		
		static std::string getBuildOptions() { 
			return	" -D T=" + ocl::OpenCLType<T>::Name + 
					OpenCLRunner::getBuildOptions<ProjectDevice>();
		}
		
		static std::string getBinaryName() { 
			return "NumberFilterKernels_" + ocl::OpenCLType<T>::Name + ocl::DeviceTraits<ProjectDevice>::BinaryExtension; 
		}

		static std::string getSourceName() {
			return "NumberFilterKernels.cl";
		}


	};

	template<typename T>
	NumberFilter<T>::NumberFilter(std::string openCLPlatform, cl_device_type openCLDeviceType, bool useOpenCLBinary)
		: OpenCLRunner(
			openCLPlatform,
			openCLDeviceType,
			useOpenCLBinary,
			NumberFilter<T>::getBuildOptions(),
			NumberFilter<T>::getSourceName(),
			NumberFilter<T>::getBinaryName()
		)
	{}

	template<typename T>
	std::vector<T> NumberFilter<T>::lowpassFilter(std::vector<T> inValues, T maxValue) {

		OCL_STATUS_INITIALIZE;

		// create buffer on the device to hold input data and queue copying of input to that buffer
		T inputCount = inValues.size();
		size_t inputBytes = inputCount * sizeof(T);
		cl_mem inputBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_ONLY, inputBytes, nullptr, &OCL_STATUS));
		OCL_CHECK(clEnqueueWriteBuffer(queue, inputBuffer, false, 0, inputBytes, &inValues[0], 0, nullptr, nullptr));

		// create a buffer to return output data count
		cl_mem outputBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, inputBytes, nullptr, &OCL_STATUS));
		cl_mem outputCountBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(T), nullptr, &OCL_STATUS));		

		// launch first kernel
		T delimiter = -42;
		cl_kernel filterInputsKernel = OCL_CHECK(clCreateKernel(program, "filter_inputs", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(filterInputsKernel, 0, sizeof(cl_mem), &inputBuffer));
		OCL_CHECK(clSetKernelArg(filterInputsKernel, 1, sizeof(T) , &inputCount));
		OCL_CHECK(clSetKernelArg(filterInputsKernel, 2, sizeof(T), &maxValue));
		OCL_CHECK(clSetKernelArg(filterInputsKernel, 3, sizeof(T), &delimiter));
		OCL_CHECK(clEnqueueTask(queue, filterInputsKernel, 0, nullptr, nullptr));

		// launch second kernel
		cl_kernel accumulateOutputsKernel = OCL_CHECK(clCreateKernel(program, "accumulate_outputs", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(accumulateOutputsKernel, 0, sizeof(cl_mem), &outputBuffer));
		OCL_CHECK(clSetKernelArg(accumulateOutputsKernel, 1, sizeof(cl_mem), &outputCountBuffer));
		OCL_CHECK(clSetKernelArg(accumulateOutputsKernel, 2, sizeof(T), &inputCount));
		OCL_CHECK(clSetKernelArg(accumulateOutputsKernel, 3, sizeof(T), &delimiter));
		OCL_CHECK(clEnqueueTask(queue, accumulateOutputsKernel, 0, nullptr, nullptr));

		// read output count from device
		T outputCount = 0;
		OCL_CHECK(clEnqueueReadBuffer(queue, outputCountBuffer, CL_TRUE, 0, sizeof(T), &outputCount, 0, nullptr, nullptr));

		// create a vector and read output data into it
		vector<T> outValues(outputCount);
		if (outputCount > 0) {
			OCL_CHECK(clEnqueueReadBuffer(queue, outputBuffer, CL_TRUE, 0, outputCount * sizeof(T), &outValues[0], 0, nullptr, nullptr));
		}

		// release OpenCL resources
		OCL_CHECK(clReleaseMemObject(inputBuffer));
		OCL_CHECK(clReleaseMemObject(outputBuffer));
		OCL_CHECK(clReleaseMemObject(outputCountBuffer));
		OCL_CHECK(clReleaseKernel(filterInputsKernel));
		OCL_CHECK(clReleaseKernel(accumulateOutputsKernel));

		return outValues;
	}

}}