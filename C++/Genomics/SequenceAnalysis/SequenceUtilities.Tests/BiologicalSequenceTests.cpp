#include "stdafx.h"
#include "CppUnitTest.h"
#include "BiologicalSequence.h"

#include <memory>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;


namespace BiologicalSequenceTests
{
	void AreEqual(const char * expected, BiologicalSequence actual) {
		Assert::AreEqual(expected, actual.str().c_str());
	};

	TEST_CLASS(BiologicalSequenceTests)
	{
	public:

		TEST_METHOD(Test_ChangeThroughPointerAndReference) {

			auto sp = std::make_shared<BiologicalSequence>("ACTG");
			auto& sr = *sp;

			AreEqual("ACTG", *sp);
			AreEqual("ACTG", sr);

			sr += "T";
			AreEqual("ACTGT", sr);
			AreEqual("ACTGT", *sp);

			*sp += "G";
			AreEqual("ACTGTG", sr);
			AreEqual("ACTGTG", *sp);

		}

		TEST_METHOD(Test_GetUngappedSequence_JustGaps) {
			BiologicalSequence s("---");
			AreEqual("", s.ungapped());
		}

		TEST_METHOD(Test_GetUngappedSequence_NoGaps) {
			BiologicalSequence s("GGCT");
			AreEqual("GGCT", s.ungapped());
		}

		TEST_METHOD(Test_GetUngappedSequence_EmptySequence) {
			BiologicalSequence s("");
			AreEqual("", s.ungapped());
		}

		TEST_METHOD(Test_GetUngappedSequence_SingleGapsWithinSequence) {
			BiologicalSequence s("G-G-C-T");
			AreEqual("GGCT", s.ungapped());
		}

		TEST_METHOD(Test_GetUngappedSequence_StartWithMultipleGaps) {
			BiologicalSequence s("----G-G-C-T");
			AreEqual("GGCT", s.ungapped());
		}

		TEST_METHOD(Test_GetUngappedSequence_EndWithMultipleGaps) {
			BiologicalSequence s("G-G-C-T-----");
			AreEqual("GGCT", s.ungapped());
		}

		TEST_METHOD(Test_GetReverse_EmptySequence) {
			BiologicalSequence s("");
			AreEqual("", s.reverse());
		}

		TEST_METHOD(Test_GetReverse_Example1) {
			BiologicalSequence s("TGGT-TGGC--");
			AreEqual("--CGGT-TGGT", s.reverse());
		}
	};
}