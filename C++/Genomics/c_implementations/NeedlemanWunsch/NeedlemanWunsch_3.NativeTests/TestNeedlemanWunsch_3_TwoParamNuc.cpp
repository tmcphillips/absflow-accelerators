#include "stdafx.h"
#include "CppUnitTest.h"
#include <string.h>

#include "nw_matrix.h"
#include "sequence_utilities.h"
#include "substitution_matrix.h"
#include "TestUtilities.h"

using namespace TestUtilities;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace NeedlemanWunsch_3_Tests
{
	
	TEST_CLASS(Test_NeedlemanWunsch_3_TwoParameterNucSubstitutionModel)
	{

	private:

		nw_matrix_t* matrix;
		substitution_matrix_t* sm_matrix;

	public: 

		TEST_METHOD_INITIALIZE(Initialize) {
			matrix = 0;
			 sm_matrix = create_two_param_nuc_subs_matrix();
		}

		TEST_METHOD_CLEANUP(Cleanup) {
			if (matrix != 0) {
				nw_free_matrix(matrix);
			}

			if (sm_matrix != 0) {
				sm_delete(sm_matrix);
			}
		}


		TEST_METHOD(Test_NoGaps) {
			matrix = nw_align_sequences("ATGGCTTGAGC",
										"ATTGCTTAAGC",
										sm_matrix,
										2);

			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("ATGGCTTGAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTGCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(16, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInA) {
			matrix = nw_align_sequences("ATCGGAGGC",
										"ATTCTTAAGC",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("A-TCGGAGGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(7, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInB) {
			matrix = nw_align_sequences("ATTGGAGAGC",
										"ATTCTAAGC",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("ATTGGAGAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCTA-AGC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfA) {
			matrix = nw_align_sequences("TTCTAAGC",
										"ATTCTAGC",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("-TTCTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCT-AGC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfB) {
			matrix = nw_align_sequences("TAATGGA",
										"AACGGTA",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("TAATGG-A", matrix->gappedSequenceA);
			Utilities::AreEqual("-AACGGTA", matrix->gappedSequenceB);
			Assert::AreEqual(5, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtEndOfB) {
			matrix = nw_align_sequences("ATTAAGC",
										"AATCTAG",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("-ATTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("AATCTAG-", matrix->gappedSequenceB);
			Assert::AreEqual(2, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfA) {
			matrix = nw_align_sequences("TAATGGATACCGGAA",
										"CCTTAAGGAACGGTAAAGGAA",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("---TAATG---GATACCGGAA", matrix->gappedSequenceA);
			Utilities::AreEqual("CCTTAAGGAACGGTAAAGGAA", matrix->gappedSequenceB);
			Assert::AreEqual(6, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfB) {
			matrix = nw_align_sequences("AATTAAGGTATCCTAATGCCATA",
										"CCTAATGGATA",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("AATTAAGGTATCCTAATGCCATA", matrix->gappedSequenceA);
			Utilities::AreEqual("-----------CCTAATG-GATA", matrix->gappedSequenceB);
			Assert::AreEqual(-5, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfB) {
			matrix = nw_align_sequences("TAATGGATACCGGAATTAAGC",
										"AACGGTAAAGGAAAA",
										sm_matrix,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("TAATGGATACCGGAATTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("-AACGG-TAAAGGAA--AA--", matrix->gappedSequenceB);
			Assert::AreEqual(9, matrix->score);
		}
	};
}
