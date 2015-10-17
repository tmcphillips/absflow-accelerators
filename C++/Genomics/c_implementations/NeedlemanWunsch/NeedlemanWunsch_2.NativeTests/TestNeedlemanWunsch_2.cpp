#include "stdafx.h"
#include "CppUnitTest.h"

#include "nw_matrix.h"
#include "sequence_utilities.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace NeedlemanWunsch_2NativeTests
{		
	TEST_CLASS(Test_NeedlmanWunsch_2)
	{
	public:
		
		nw_matrix_t* matrix;

		static void AreEqual(char* expected, char* actual, bool ignoreCase = false, const wchar_t* message = NULL, const __LineInfo* pLineInfo = NULL)
		{
			Assert::AreEqual((const char*) expected, (const char*) actual, ignoreCase, message, pLineInfo);
		}


		void AssertIsSane(nw_matrix_t* matrix) {

			// make sure two gapped sequences have the same length
			Assert::AreEqual(
				strlen(matrix->gappedSequenceA), 
				strlen(matrix->gappedSequenceB)
			);

			// make sure the alignment score is the same as the score in the bottom, right-hand cell
			Assert::AreEqual(
				matrix->cell[matrix->columns-1][matrix->rows-1].score, 
				matrix->score
			);

			// make the sure the gapped sequences are the same as the original sequences when gaps are removed
			AreEqual(
				matrix->sequenceA, 
				get_ungapped_sequence(matrix->gappedSequenceA)
			);

			AreEqual(
				matrix->sequenceB, 
				get_ungapped_sequence(matrix->gappedSequenceB)
			);
		}

	public: 

		TEST_METHOD_INITIALIZE(Initialize) {
			matrix = 0;
		}

		TEST_METHOD_CLEANUP(Cleanup) {
			if (matrix != 0) {
				nw_free_matrix(matrix);
			}
		}


		TEST_METHOD(Test_NoGaps) {
			matrix = nw_align_sequences("ATGGCTTGAGC",
										"ATTGCTTAAGC");

			AssertIsSane(matrix);
			AreEqual("ATGGCTTGAGC", matrix->gappedSequenceA);
			AreEqual("ATTGCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(16, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInA) {
			matrix = nw_align_sequences("ATCGGAGGC",
										"ATTCTTAAGC");
			AssertIsSane(matrix);
			AreEqual("AT-CGGAGGC", matrix->gappedSequenceA);
			AreEqual("ATTCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(7, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInB) {
			matrix = nw_align_sequences("ATTGGAGAGC",
										"ATTCTAAGC");
			AssertIsSane(matrix);
			AreEqual("ATTGGAGAGC", matrix->gappedSequenceA);
			AreEqual("ATTCTA-AGC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfA) {
			matrix = nw_align_sequences("TTCTAAGC",
										"ATTCTAGC");
			AssertIsSane(matrix);
			AreEqual("-TTCTAAGC", matrix->gappedSequenceA);
			AreEqual("ATTCTA-GC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfB) {
			matrix = nw_align_sequences("TAATGGA",
										"AACGGTA");
			AssertIsSane(matrix);
			AreEqual("TAATGG-A", matrix->gappedSequenceA);
			AreEqual("-AACGGTA", matrix->gappedSequenceB);
			Assert::AreEqual(5, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtEndOfA) {
			matrix = nw_align_sequences("ATTAAG",
										"AATCTAGC");
			AssertIsSane(matrix);
			AreEqual("A-T-TAAG-", matrix->gappedSequenceA);
			AreEqual("AATCTA-GC", matrix->gappedSequenceB);
			Assert::AreEqual(2, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtEndOfB) {
			matrix = nw_align_sequences("ATTAAGC",
										"AATCTAG");
			AssertIsSane(matrix);
			AreEqual("A-T-TAAGC", matrix->gappedSequenceA);
			AreEqual("AATCTA-G-", matrix->gappedSequenceB);
			Assert::AreEqual(2, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfA) {
			matrix = nw_align_sequences("TAATGGATACCGGAA",
										"CCTTAAGGAACGGTAAAGGAA");
			AssertIsSane(matrix);
			AreEqual("--T-AATGGA----TACCGGAA", matrix->gappedSequenceA);
			AreEqual("CCTTAA-GGAACGGTAAAGGAA", matrix->gappedSequenceB);
			Assert::AreEqual(6, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfB) {
			matrix = nw_align_sequences("AATTAAGGTATCCTAATGCCATA",
										"CCTAATGGATA");
			AssertIsSane(matrix);
			AreEqual("AATTAAGGTATCCTAATGCCATA", matrix->gappedSequenceA);
			AreEqual("-----------CCTAATGG-ATA", matrix->gappedSequenceB);
			Assert::AreEqual(-5, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfA) {
			matrix = nw_align_sequences("TAATGGATACCGGAA",
										"AACGGTAAAGGAAAATTAAGG");
			AssertIsSane(matrix);
			AreEqual("TAATGGATACCGGAA--------", matrix->gappedSequenceA);
			AreEqual("-AACGG-TAAAGGAAAATTAAGG", matrix->gappedSequenceB);
			Assert::AreEqual(-3, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfB) {
			matrix = nw_align_sequences("TAATGGATACCGGAATTAAGC",
										"AACGGTAAAGGAAAA");
			AssertIsSane(matrix);
			AreEqual("TAATGGATACCGGAATTAAGC", matrix->gappedSequenceA);
			AreEqual("-AACGG-TAAAGGAA--AA--", matrix->gappedSequenceB);
			Assert::AreEqual(9, matrix->score);
		}

	};
}