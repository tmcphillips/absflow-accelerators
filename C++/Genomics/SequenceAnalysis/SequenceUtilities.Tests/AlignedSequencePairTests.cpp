#include "stdafx.h"
#include "CppUnitTest.h"
#include <sstream>

#include "AlignedSequencePair.h"

using std::endl;
using std::stringstream;

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace SequenceUtilitiesTests
{
	TEST_CLASS(AlignedSequencePairTests)
	{
	public:
		
		TEST_METHOD(Test_RenderAlignment_NoModel_SameLength) {

			stringstream ss;

			ss << AlignedSequencePair{
				{ "T-GGTTGG-C-" },
				{ "TAG--GCG-CC" }
			};
				
			Assert::AreEqual(
				"T-GGTTGG-C-\n"
				"| |    | | \n"
				"TAG--GCG-CC\n",
				ss.str().c_str()
				);
		}


		TEST_METHOD(Test_RenderAlignment_NoModel_FirstShorter) {

			stringstream ss;

			ss << AlignedSequencePair{
				{ "TAG--G" },
				{ "T-GGTTGG-C-" }
			};

			Assert::AreEqual(
				"TAG--G\n"
				"| |   \n"
				"T-GGTTGG-C-\n", 
				ss.str().c_str()
				);
		}

		TEST_METHOD(Test_RenderAlignment_NoModel_SecondShorter) {

			stringstream ss;

			ss << AlignedSequencePair{
				{ "T-GGTTGG-C-" },
				{ "TAG--G" }
			};

			Assert::AreEqual(
				"T-GGTTGG-C-\n"
				"| |   \n"
				"TAG--G\n",
				ss.str().c_str()
				);
		}


		TEST_METHOD(Test_RenderAlignment_Blosum50Model) {

			stringstream ss;

			ss << AlignedSequencePair{
				{ "GSLA--LSVQDL-LKDKLAFIR-DFNNP---KKITTNQRIVAPLATILY---HHPRWVVL-SHLGRPNG" },
				{ "MSLSLKLS-QEGDLK-KRSF---DFNVPLDGKYITS----VAALPTIKYVLEHHPRFVVLSNHI-RP--" },
				blosum50ProteinModel()
			};

			Assert::AreEqual(
				"GSLA--LSVQDL-LKDKLAFIR-DFNNP---KKITTNQRIVAPLATILY---HHPRWVVL-SHLGRPNG\n"
				" ||:  || |:  || | :|   ||| |   | ||:    || | || |   ||||:||| :|: ||  \n"
				"MSLSLKLS-QEGDLK-KRSF---DFNVPLDGKYITS----VAALPTIKYVLEHHPRFVVLSNHI-RP--\n",
				ss.str().c_str()
				);
		}

		TEST_METHOD(Test_FractionIdentity_BothEmpty) {
			auto a = AlignedSequencePair{ { "" }, { "" } };
			Assert::AreEqual(0.0, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_FirstEmpty) {
			auto a = AlignedSequencePair{ { "" }, { "TGGTTGGC" } };
			Assert::AreEqual(0.0, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SecondEmpty) {
			auto a = AlignedSequencePair{ { "TGGTTGGC" }, { "" } };
			Assert::AreEqual(0.0, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SameLength_ExactMatch_NoGaps) {
			auto a = AlignedSequencePair{
				{ "TGGTTGGC" },
				{ "TGGTTGGC" } };
			Assert::AreEqual(1.0, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SameLength_ExactMatch_WithGaps) {
			auto a = AlignedSequencePair{
				{ "TGGT-TGGC--" },
				{ "TGGT-TGGC--" } };
			Assert::AreEqual(1.0, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SameLength_HalfMatch_NoGaps) {
			auto a = AlignedSequencePair{
				{ "TGGTTGGC" },
				{ "TAGGCGCC" } };
			Assert::AreEqual(0.5, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SameLength_HalfMatch_WithGaps) {
			auto a = AlignedSequencePair{
				{ "TGGT-TGGC--" },
				{ "TAGG-CGCC--" } };
			Assert::AreEqual(0.5, a.fractionIdentity(), 0.0001);
		}

		TEST_METHOD(Test_FractionIdentity_SameLength_HalfMatch_DifferInGaps) {
			auto a = AlignedSequencePair{
				{ "T-GGTTGG-C-" },
				{ "TAG--GCG-CC" } };
			Assert::AreEqual(0.5, a.fractionIdentity(), 0.0001);
		}
	};
}