#pragma once
#include "opencl_utilities.h"
#include <vector>
#include <string>
#include "PatternMatchingConfig.h"

namespace PatternMatching { namespace Native {
	bool matchesApproximately(std::string pattern, std::string text, size_t maxMismatches);
	std::vector<size_t> findApproximateMatches(std::string pattern, std::string text, size_t maxMismatches);
	std::vector<size_t> findExactPattern(std::string pattern, std::string text);
}}


namespace PatternMatching {
	namespace OpenCL {

	class PatternMatcher {
	public:
		PatternMatcher(std::string platform, cl_device_type deviceType, bool useBinary);
		~PatternMatcher();

		std::vector<cl_uint> findPattern(char const * pattern, char const * text, cl_uint maxMismatch);

		std::vector<cl_uint> findExactPattern(char const * pattern, char const * text) {
			return findPattern(pattern, text, 0);
		}

	private:
		void PatternMatcher::findMatchesInText(cl_mem textBuffer, cl_mem patternBuffer, cl_mem matchBuffer, cl_uint textSize, cl_uint patternSize, cl_uint maxMismatch);
		void PatternMatcher::findExactMatchesInText(cl_mem textBuffer, cl_mem patternBuffer, cl_mem matchBuffer, cl_uint textSize, cl_uint patternSize);
		void PatternMatcher::computePrefixSum(cl_mem & inputBuffer, cl_uint bufferElementCount);
		void PatternMatcher::packIndicesOfValueSteps(cl_mem packedIndicesBuffer, cl_mem valuesBuffer, cl_uint valuesCount);
		cl_context context;
		cl_command_queue queue;
		cl_program program;
	};
}}

