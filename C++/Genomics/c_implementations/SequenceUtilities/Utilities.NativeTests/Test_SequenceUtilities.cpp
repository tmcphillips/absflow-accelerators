#include "stdafx.h"
#include "CppUnitTest.h"
#include "sequence_utilities.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UtilitiesNativeTests
{
	TEST_CLASS(Test_SequenceUtilities)
	{
	public:
		
		TEST_METHOD(Test_GetUngappedSequence_JustGaps) {
			char* gappedSequence = "---";
			Assert::AreEqual("", get_ungapped_sequence(gappedSequence));
		}

		TEST_METHOD(Test_GetUngappedSequence_EmptySequence) {
			char* gappedSequence = "";
			Assert::AreEqual("", get_ungapped_sequence(gappedSequence));
		}

		TEST_METHOD(Test_GetUngappedSequence_SingleGapsWithinSequence) {
			char* gappedSequence = "G-G-C-T";
			Assert::AreEqual("GGCT", get_ungapped_sequence(gappedSequence));
		}

		TEST_METHOD(Test_GetUngappedSequence_StartWithMultipleGaps) {
			char* gappedSequence = "----G-G-C-T";
			Assert::AreEqual("GGCT", get_ungapped_sequence(gappedSequence));
		}

		TEST_METHOD(Test_GetUngappedSequence_EndWithMultipleGaps) {
			char* gappedSequence = "G-G-C-T-----";
			Assert::AreEqual("GGCT", get_ungapped_sequence(gappedSequence));
		}
		
		TEST_METHOD(Test_GetReverseSequence_EmptySequence) {
			char *forwardSequence = "";
			Assert::AreEqual("", get_reverse_sequence(forwardSequence));
		}

		TEST_METHOD(Test_GetReverseSequence_Example1) {
			char *forwardSequence = "TGGT-TGGC--";
			Assert::AreEqual("--CGGT-TGGT", get_reverse_sequence(forwardSequence));
		}
	};
}