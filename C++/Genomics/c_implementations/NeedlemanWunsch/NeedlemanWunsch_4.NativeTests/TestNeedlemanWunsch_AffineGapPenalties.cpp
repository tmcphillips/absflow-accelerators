#include "stdafx.h"
#include "CppUnitTest.h"

#include "nw_matrix.h"
#include "sequence_utilities.h"
#include "substitution_matrix.h"
#include "fasta_reader.h"
#include "TestUtilities.h"

using namespace TestUtilities;

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace NeedlemanWunsch_4NativeTests
{		
	TEST_CLASS(NeedlemanWunsch_AffineGapPenalties) {

	private:

		nw_matrix_t* matrix;
		substitution_matrix_t* two_param_nuc_substitution_matrix;
		substitution_matrix_t* blosum50_substitution_matrix;

	public: 

		TEST_METHOD_INITIALIZE(Initialize) {
			matrix = 0;
			two_param_nuc_substitution_matrix	= create_two_param_nuc_subs_matrix();
			blosum50_substitution_matrix		= create_blosum50_subs_matrix();
		}

		TEST_METHOD_CLEANUP(Cleanup) {
			sm_delete(two_param_nuc_substitution_matrix);
			sm_delete(blosum50_substitution_matrix);
			if (matrix != 0) {
				nw_free_matrix(matrix);
			}
		}


		TEST_METHOD(TestAffineGapPenalty_HandCheckedMatrices)
		{
			matrix = nw_align_sequences(
				"ATTAAG",
				"AATCTAGC",
				two_param_nuc_substitution_matrix,
				2,
				1
			);

			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("-AT-TAAG", matrix->gappedSequenceA);
			Utilities::AreEqual("AATCTAGC", matrix->gappedSequenceB);
			Assert::AreEqual(2, matrix->score);

			int m_expected[7*9] = {
				 0, -2, -3, -4, -5, -6, -7,
				-2,  2,  0, -1, -2, -3, -4,
				-3,  0,  1, -1,  1,  0, -2,
				-4, -1,  2,  3,  1,  0, -1,
				-5, -2,  0,  1,  2,  0, -1,
				-6, -3,  0,  2,  0,  1, -1,
				-7, -4, -2,  0,  4,  2,  1,
				-8, -5, -3, -1,  2,  3,  4,
				-9, -6, -4, -2,  1,  1,  2
			};

			Utilities::AreEqual(m_expected, matrix->m, 7, 9);

			int ia_expected[7*9] = {
				 0, -4, -5, -6, -7, -8, -9,
				-4, -4, -5, -6, -7, -8, -9,
				-5,  0, -2, -3, -4, -5, -6,
				-6, -1, -1, -3, -1, -2, -4,
				-7, -2,  0,  1, -1, -2, -3,
				-8, -3, -1,  0,  0, -2, -3,
				-9, -4, -2,  0, -1, -1, -3,
			   -10, -5, -3, -1,  2,  0, -1,
			   -11, -6, -4, -2,  1,  1,  2
			};

			Utilities::AreEqual(ia_expected, matrix->ia, 7, 9);

			int ib_expected[7*9] = {
				 0, -4, -5, -6, -7, -8, -9,
				-4, -4,  0, -1, -2, -3, -4,
				-5, -5, -2, -1, -2, -1, -2,
				-6, -6, -3,  0,  1,  0, -1,
				-7, -7, -4, -2, -1,  0, -1,
				-8, -8, -5, -2,  0, -1, -1,
				-9, -9, -6, -4, -2,  2,  1,
			   -10,-10, -7, -5, -3,  0,  1,
			   -11,-11, -8, -6, -4, -1, -1,
			};

			Utilities::AreEqual(ib_expected, matrix->ib, 7, 9);
		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_ZeroPenalty)
		{
			char header[81];
			char human_sequence[1000];
			char chicken_sequence[1000];
			char displayString[1000];

			read_single_sequence_fasta_file(
				header, 
				human_sequence,
				R"(..\..\SampleData\ProteinSequences\human_phc.fasta)"
			);
			
			read_single_sequence_fasta_file(
				header, 
				chicken_sequence,
				R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)"
			);

			matrix = nw_align_sequences(
				human_sequence,
				chicken_sequence,
				blosum50_substitution_matrix,
				0,
				0);

			sprint_alignment_with_similarities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB, blosum50_substitution_matrix);
			Utilities::AreEqual(
				"ALLLQPLLGAQGAP-LEPVYPGDNATP-EQM-AQ-YAAD-LRRYINMLTRPRYGKRHKEDTLAF\n"
				"           | |  :| ||||:| | | :  : |  | |::|:|::|      ||:     :\n"
				"-----------G-PS-QPTYPGDDA-PVEDLI-RFY--DNLQQYLNVVT------RHR-----Y\n",
				displayString);
		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_LinearPenalty)
		{
			char header[81];
			char human_sequence[1000];
			char chicken_sequence[1000];
			char displayString[1000];

			read_single_sequence_fasta_file(
				header, 
				human_sequence,
				R"(..\..\SampleData\ProteinSequences\human_phc.fasta)"
			);
			
			read_single_sequence_fasta_file(
				header, 
				chicken_sequence,
				R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)"
			);

			matrix = nw_align_sequences(
				human_sequence,
				chicken_sequence,
				blosum50_substitution_matrix,
				8,
				8);

			sprint_alignment_with_similarities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB, blosum50_substitution_matrix);
			Utilities::AreEqual(
				"ALLLQPLLGAQGAPLEPVYPGDNATPEQMAQYAADLRRYINMLTRPRYGKRHKEDTLAF\n"
				"     |   :|     | ||||:|  | : ::  :|::|:|::|      ||:     :\n"
				"G----P---SQ-----PTYPGDDAPVEDLIRFYDNLQQYLNVVT------RHR-----Y\n",
				displayString);
		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_AffinePenalty)
		{
			char header[81];
			char human_sequence[1000];
			char chicken_sequence[1000];
			char displayString[1000];

			read_single_sequence_fasta_file(
				header, 
				human_sequence,
				R"(..\..\SampleData\ProteinSequences\human_phc.fasta)"
			);
			
			read_single_sequence_fasta_file(
				header, 
				chicken_sequence,
				R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)"
			);

			matrix = nw_align_sequences(
				human_sequence,
				chicken_sequence,
				blosum50_substitution_matrix,
				10,
				1);

			sprint_alignment_with_similarities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB, blosum50_substitution_matrix);
			Utilities::AreEqual(
				"ALLLQPLLGAQGAPLEPVYPGDNATPEQMAQYAADLRRYINMLTRPRYGKRHKEDTLAF\n"
				"             | :| ||||:|  | : ::  :|::|:|::|| ||           \n"
				"------------GPSQPTYPGDDAPVEDLIRFYDNLQQYLNVVTRHRY-----------\n",
				displayString);
		}
	};
}