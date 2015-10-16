#include "PatternMatching.h"

using std::string;
using std::vector;

namespace PatternMatching { namespace Native
{
	bool matchesApproximately(string pattern, string text, size_t maxMismatches) {
		int mismatches = 0;
		for (unsigned i = 0; i < pattern.length(); i++) {
			if (pattern[i] != text[i]) {
				if (++mismatches > maxMismatches) {
					return false;
				}
			}
		}
		return true;
	}

	vector<size_t> findApproximateMatches(string pattern, string text, size_t maxMismatches) {
		vector<size_t> matches;
		size_t patternLength = pattern.length();
		size_t substringCount = text.length() - patternLength + 1;
		for (size_t i = 0; i < substringCount; i++) {
			string substring = text.substr(i, patternLength);
			if (matchesApproximately(pattern, substring, maxMismatches)) {
				matches.push_back(i);
			}
		}
		return matches;
	}

	vector<size_t> findExactPattern(string pattern, string genome) {
		vector<size_t> matches;
		size_t position = 0;
		while (true) {
			position = genome.find(pattern, position);
			if (position == string::npos) break;
			matches.push_back(position++);
		}
		return matches;
	}
}}

namespace PatternMatching { namespace OpenCL {

	PatternMatcher::PatternMatcher(std::string platform, cl_device_type deviceType, bool useBinary) {
		std::string buildOptions{};
		std::string binaryName = "PatternMatching.aocx";
		program = ocl::buildProgramForDevice(platform, deviceType, useBinary,
			binaryName, "PatternMatching.cl", buildOptions,
			context, queue);
	}

	PatternMatcher::~PatternMatcher() {
		OCL_STATUS_INITIALIZE;
		OCL_CHECK(clReleaseProgram(program));
		OCL_CHECK(clReleaseCommandQueue(queue));
		OCL_CHECK(clReleaseContext(context));
	}

	void PatternMatcher::findMatchesInText(cl_mem textBuffer, cl_mem patternBuffer, cl_mem matchBuffer, cl_uint textSize, cl_uint patternSize, cl_uint maxMismatch) {
		OCL_STATUS_INITIALIZE;
		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "find_matches", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &textBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_mem), &patternBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(cl_mem), &matchBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 3, sizeof(cl_uint), &patternSize));
		OCL_CHECK(clSetKernelArg(kernel, 4, sizeof(cl_uint), &maxMismatch));
		size_t globalWorkSize[1] = { textSize - patternSize + 1 };
		OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	void PatternMatcher::findExactMatchesInText(cl_mem textBuffer, cl_mem patternBuffer, cl_mem matchBuffer, cl_uint textSize, cl_uint patternSize) {
		OCL_STATUS_INITIALIZE;
		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "find_exact_matches", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &textBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_mem), &patternBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(cl_mem), &matchBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 3, sizeof(cl_uint), &patternSize));
		size_t globalWorkSize[1] = { textSize - patternSize + 1 };
		OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	void PatternMatcher::computePrefixSum(cl_mem & inputBuffer, cl_uint bufferElementCount) {

		OCL_STATUS_INITIALIZE;

		cl_mem localBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_WRITE, bufferElementCount * sizeof(cl_uint), nullptr, &OCL_STATUS));

		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "prefix_sum_step", &OCL_STATUS));
		size_t globalWorkSize[1] = { bufferElementCount };
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_uint), &bufferElementCount));

		for (cl_uint offset = 1; offset < bufferElementCount; offset *= 2) {
			OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_uint), &offset));
			OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(cl_mem), &inputBuffer));
			OCL_CHECK(clSetKernelArg(kernel, 3, sizeof(cl_mem), &localBuffer));
			OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
			std::swap(inputBuffer, localBuffer);
		}

		OCL_CHECK(clReleaseMemObject(localBuffer));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	void PatternMatcher::packIndicesOfValueSteps(cl_mem packedIndicesBuffer, cl_mem valuesBuffer, cl_uint valuesCount) {
		OCL_STATUS_INITIALIZE;
		cl_kernel kernel = OCL_CHECK(clCreateKernel(program, "pack_indices_of_value_steps", &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &packedIndicesBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(cl_mem), &valuesBuffer));
		OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(cl_uint), &valuesCount));
		size_t globalWorkSize[1] = { valuesCount };
		OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 1, nullptr, globalWorkSize, nullptr, 0, nullptr, nullptr));
		OCL_CHECK(clReleaseKernel(kernel));
	}

	std::vector<cl_uint> PatternMatcher::findPattern(char const * pattern, char const * text, cl_uint maxMismatch) {

		OCL_STATUS_INITIALIZE;

		size_t textSize = strlen(text);
		size_t patternSize = strlen(pattern);
		size_t possibleMatchSites = textSize - patternSize + 1;

		// create a buffer for storing text on device and copy text to device
		cl_mem textBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_ONLY, textSize, nullptr, &OCL_STATUS));
		OCL_CHECK(clEnqueueWriteBuffer(queue, textBuffer, CL_FALSE, 0, textSize, text, 0, nullptr, nullptr));

		// create a buffer for storing pattern on device and copy pattern to device
		cl_mem patternBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_ONLY, patternSize, nullptr, &OCL_STATUS));
		OCL_CHECK(clEnqueueWriteBuffer(queue, patternBuffer, CL_FALSE, 0, patternSize, pattern, 0, nullptr, nullptr));

		// create a buffer for storing flags indicating starting positions of found matches
		size_t matchBufferSize = possibleMatchSites * sizeof(cl_uint);
		cl_mem matchBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_READ_WRITE, matchBufferSize, nullptr, &OCL_STATUS));

		// launch kernel to find matches in text buffer 
		if (maxMismatch == 0) {
			this->findExactMatchesInText(textBuffer, patternBuffer, matchBuffer, textSize, patternSize);
		} else {
			this->findMatchesInText(textBuffer, patternBuffer, matchBuffer, textSize, patternSize, maxMismatch);
		}

		// release the text and pattern buffers
		OCL_CHECK(clReleaseMemObject(textBuffer));
		OCL_CHECK(clReleaseMemObject(patternBuffer));

		// compute prefix sum of match-starts buffer 
		this->computePrefixSum(matchBuffer, textSize);

		// read total of matches found from last element of match-starts buffer
		cl_uint matchCount = 0;
		cl_uint offsetOfFinalMatchBufferElement = (possibleMatchSites - 1) * sizeof(cl_uint);
		OCL_CHECK(clEnqueueReadBuffer(queue, matchBuffer, CL_TRUE, offsetOfFinalMatchBufferElement, sizeof(cl_uint), &matchCount, 0, nullptr, nullptr));

		// create a buffer to store packed locations of match starts
		size_t locationsBufferSize = matchCount * sizeof(cl_uint);
		cl_mem locationsBuffer = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, locationsBufferSize, nullptr, &OCL_STATUS));

		// pack the found location coordinates into the locations buffer
		this->packIndicesOfValueSteps(locationsBuffer, matchBuffer, possibleMatchSites);

		// release the match buffer
		OCL_CHECK(clReleaseMemObject(matchBuffer));

		// read the match-start positions from the device into a vector to be returned to caller
		vector<cl_uint> matchLocations(matchCount);
		OCL_CHECK(clEnqueueReadBuffer(queue, locationsBuffer, CL_TRUE, 0, locationsBufferSize, &matchLocations[0], 0, nullptr, nullptr));

		// release OpenCL resources
		OCL_CHECK(clReleaseMemObject(locationsBuffer));

		// return vector match starts
		return matchLocations;
	}
}}