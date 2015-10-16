#pragma once
#include "stdafx.h"
#include "opencl_utilities.h"
#include "OpenCLRunner.h"

namespace SieveOfEratosthenes
{
	std::vector<int> lookupPrimesUpTo(int n);

	template<typename T>
	class PrimeSieve : public OpenCLRunner {
	public:
		PrimeSieve(std::string openCLPlatform, cl_device_type openCLDeviceType, bool useOpenCLBinary);
		T countPrimesUpTo(T maxPrime);
		std::vector<T> enumeratePrimesUpTo(T maxPrime);
	private:
		void initializeSieveBuffer(cl_mem buffer, T maxPrime);
		void packIndicesOfValueSteps(cl_mem packedIndicesBuffer, cl_mem valuesBuffer, T valuesCount);
		void performPrimeSieve(cl_mem sieveBuffer, T maxPrime);
		void reduceNonzeroElements(cl_mem buffer, T bufferElementCount);
		void computePrefixSum(cl_mem & inputBuffer, T bufferElementCount);
	};

	template<typename T>
	PrimeSieve<T>::PrimeSieve(std::string openCLPlatform, cl_device_type openCLDeviceType, bool useOpenCLBinary)
		: OpenCLRunner(
		openCLPlatform, 
		openCLDeviceType, 
		useOpenCLBinary, 
		"-D T=" + ocl::OpenCLType<T>::Name, 
		"PrimeSieveKernels.cl", 
		"PrimeSieveKernels_" + ocl::OpenCLType<T>::Name + ocl::DeviceTraits<ProjectDevice>::BinaryExtension)
		{}

	template<typename T>
	void PrimeSieve<T>::initializeSieveBuffer(cl_mem buffer, T maxPrime) {
		OCL_STATUS_INITIALIZE;
		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "initialize_sieve", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(T), &maxPrime));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_mem), &buffer));
		size_t globalWorkSize[1] = { maxPrime + 1 };
		OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	template<typename T>
	void PrimeSieve<T>::packIndicesOfValueSteps(cl_mem packedIndicesBuffer, cl_mem valuesBuffer, T valuesCount) {
		OCL_STATUS_INITIALIZE;
		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "pack_indices_of_value_steps", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &packedIndicesBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_mem), &valuesBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(T), &valuesCount));
		size_t globalWorkSize[1] = { valuesCount };
		OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	template<typename T>
	void PrimeSieve<T>::performPrimeSieve(cl_mem sieveBuffer, T maxPrime) {

		OCL_STATUS_INITIALIZE;

		// determine the upper bound on prime numbers with multiples <= maxPrime
		T sqrtN = (T) floor(sqrt(maxPrime));

		cl_kernel zeroCompositeKernel = OCL_CHECK(clCreateKernel(program, "zero_composite", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(zeroCompositeKernel, 0, sizeof(T), &maxPrime));
		OCL_CHECK(clSetKernelArg(zeroCompositeKernel, 2, sizeof(cl_mem), &sieveBuffer));

		T const defaultChunkSize = 32;
		T chunkSize = min(defaultChunkSize, maxPrime);
		T positionInChunk = 2;
		T chunkStart = 0;

		auto hSieveWindow = new T[chunkSize];

		// ensure that first chunk of buffer is copied to host during first iteration of loop
		bool refreshRequired = true;

		// scan integers less than the upper bound
		for (T i = 2; i <= sqrtN; ++i, ++positionInChunk) {

			// move chunk forward if currently at end of chunk
			if (positionInChunk == chunkSize) {
				chunkStart += chunkSize;
				positionInChunk = 0;
				if (i + chunkSize > sqrtN) chunkSize = sqrtN - i + 1;
				refreshRequired = true;
			}

			// copy current chunk of buffer to host if required
			if (refreshRequired) {
				OCL_CHECK(clEnqueueReadBuffer(queue, sieveBuffer, CL_TRUE,
					chunkStart * sizeof(T), chunkSize * sizeof(T), hSieveWindow,
					0, nullptr, nullptr));
				refreshRequired = false;
			}

			// if current value has not been marked as composite, mark its multiples as composite
			if (hSieveWindow[i - chunkStart]) {
				T currentPrime = i;
				OCL_CHECK(clSetKernelArg(zeroCompositeKernel, 1, sizeof(T), &currentPrime));
				size_t compositesToMark = (maxPrime - currentPrime * currentPrime) / currentPrime + 1;
				size_t globalWorkSize[1] = { ((compositesToMark / 16) + 1) * 16 };
				size_t localWorkSize[1] = { 16 };
				OCL_CHECK(clEnqueueNDRangeKernel(queue, zeroCompositeKernel, 1, nullptr, globalWorkSize, localWorkSize, 0, nullptr, nullptr));
				refreshRequired = true;
			}
		}

		OCL_CHECK(clReleaseKernel(zeroCompositeKernel));
	}

	template<typename T>
	void PrimeSieve<T>::reduceNonzeroElements(cl_mem buffer, T bufferElementCount) {
		
		OCL_STATUS_INITIALIZE;

		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "reduce_nonzero_elements", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffer));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(T), &bufferElementCount));

		size_t globalWorkSize[1] = { bufferElementCount };
		for (T offset = 1; offset < bufferElementCount; offset *= 2) {
			globalWorkSize[0] = globalWorkSize[0] / 2 + 1;
			OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(T), &offset));
			OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		}

		OCL_CHECK(clReleaseKernel(kernel));
	}

	template<typename T>
	void PrimeSieve<T>::computePrefixSum(cl_mem & inputBuffer, T bufferElementCount) {

		OCL_STATUS_INITIALIZE;

		cl_mem localBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_WRITE, bufferElementCount * sizeof(T), nullptr, &OCL_STATUS));

		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "prefix_sum_step", &OCL_STATUS));
		size_t globalWorkSize[1] = { bufferElementCount };
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(T), &bufferElementCount));

		for (T offset = 1; offset < bufferElementCount; offset *= 2) {
			OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(T), &offset));
			OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(cl_mem), &inputBuffer));
			OCL_CHECK(clSetKernelArg(kernel, 3, sizeof(cl_mem), &localBuffer));
			OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
			std::swap(inputBuffer, localBuffer);
		}

		OCL_CHECK(clReleaseMemObject(localBuffer));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	template<typename T>
	T PrimeSieve<T>::countPrimesUpTo(T maxPrime) {

		OCL_STATUS_INITIALIZE;

		// create a buffer on device to store intermediate and final values during sieving of prime numbers
		T bufferElementCount = maxPrime + 1;
		size_t sieveBufferSize = bufferElementCount * sizeof(T);
		cl_mem sieveBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_WRITE, sieveBufferSize, nullptr, &OCL_STATUS));

		// initialize all buffer elements that are potential primes to 1
		initializeSieveBuffer(sieveBuffer, maxPrime);

		// set to zero all buffer elements determine to be composite
		performPrimeSieve(sieveBuffer, maxPrime);

		// reduce remaining non-zero elements
		reduceNonzeroElements(sieveBuffer, maxPrime);

		// read final count of prime numbers from first element of buffer
		T count = 0;
		OCL_CHECK(clEnqueueReadBuffer(queue, sieveBuffer, CL_TRUE, 0, sizeof(T), &count, 0, nullptr, nullptr));

		// release all OpenCL resources
		OCL_CHECK(clReleaseMemObject(sieveBuffer));

		// return vector of enumerated primes (empty if enumeration == false)
		return count;
	}

	template<typename T>
	std::vector<T> PrimeSieve<T>::enumeratePrimesUpTo(T maxPrime) {

		OCL_STATUS_INITIALIZE;

		// create a buffer on device to store intermediate and final values during sieving of prime numbers
		T bufferElementCount = maxPrime + 1;
		size_t sieveBufferSize = bufferElementCount * sizeof(T);
		cl_mem sieveBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_WRITE, sieveBufferSize, nullptr, &OCL_STATUS));

		// initialize all buffer elements that are potential primes to 1
		initializeSieveBuffer(sieveBuffer, maxPrime);

		// set to zero all buffer elements determine to be composite
		performPrimeSieve(sieveBuffer, maxPrime);

		// replace prime sieve values with their prefix sum such each element corresponding to
		// a prime number has a value equal to its position in a list of prime numbers and is one
		// greater than the value of the element to its left
		computePrefixSum(sieveBuffer, bufferElementCount);

		// get count of unique prime numbers discovered by retrieving last value in prefix sum results
		T primeNumberCount = 0;
		OCL_CHECK(clEnqueueReadBuffer(queue, sieveBuffer, CL_TRUE, maxPrime * sizeof(T), sizeof(T), &primeNumberCount, 0, nullptr, nullptr));

		// create a buffer on device to pack prime numbers into
		cl_mem primesBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, primeNumberCount * sizeof(T), nullptr, &OCL_STATUS));

		// pack the prime numbers flagged by the sieve buffer into the primes buffer
		packIndicesOfValueSteps(primesBuffer, sieveBuffer, maxPrime);

		// read the packed primes into a vector to be retured to caller
		std::vector<T> primes(primeNumberCount);
		OCL_CHECK(clEnqueueReadBuffer(queue, primesBuffer, CL_TRUE, 0, primeNumberCount * sizeof(T), &primes[0], 0, nullptr, nullptr));

		// release OpenCL resources
		OCL_CHECK(clReleaseMemObject(primesBuffer));
		OCL_CHECK(clReleaseMemObject(sieveBuffer));

		// return vector of enumerated primes
		return primes;
	}

}