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
	TEST_CLASS(NeedlemanWunsch_LinearGapPenalties)
	{
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

		TEST_METHOD(Test_NoGaps) {
			matrix = nw_align_sequences("ATGGCTTGAGC",
										"ATTGCTTAAGC",
										two_param_nuc_substitution_matrix,
										2,
										2);

			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("ATGGCTTGAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTGCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(16, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInA) {
			matrix = nw_align_sequences("ATCGGAGGC",
										"ATTCTTAAGC",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("A-TCGGAGGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCTTAAGC", matrix->gappedSequenceB);
			Assert::AreEqual(7, matrix->score);
		}

		TEST_METHOD(Test_SingleGapInB) {
			matrix = nw_align_sequences("ATTGGAGAGC",
										"ATTCTAAGC",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("ATTGGAGAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCTA-AGC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfA) {
			matrix = nw_align_sequences("TTCTAAGC",
										"ATTCTAGC",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("-TTCTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("ATTCT-AGC", matrix->gappedSequenceB);
			Assert::AreEqual(10, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtStartOfB) {
			matrix = nw_align_sequences("TAATGGA",
										"AACGGTA",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("TAATGG-A", matrix->gappedSequenceA);
			Utilities::AreEqual("-AACGGTA", matrix->gappedSequenceB);
			Assert::AreEqual(5, matrix->score);
		}

		TEST_METHOD(Test_SingleGapAtEndOfB) {
			matrix = nw_align_sequences("ATTAAGC",
										"AATCTAG",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("-ATTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("AATCTAG-", matrix->gappedSequenceB);
			Assert::AreEqual(2, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfA) {
			matrix = nw_align_sequences("TAATGGATACCGGAA",
										"CCTTAAGGAACGGTAAAGGAA",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("---TAATG---GATACCGGAA", matrix->gappedSequenceA);
			Utilities::AreEqual("CCTTAAGGAACGGTAAAGGAA", matrix->gappedSequenceB);
			Assert::AreEqual(6, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfB) {
			matrix = nw_align_sequences("AATTAAGGTATCCTAATGCCATA",
										"CCTAATGGATA",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("AATTAAGGTATCCTAATGCCATA", matrix->gappedSequenceA);
			Utilities::AreEqual("-----------CCTAATG-GATA", matrix->gappedSequenceB);
			Assert::AreEqual(-5, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfB) {
			matrix = nw_align_sequences("TAATGGATACCGGAATTAAGC",
										"AACGGTAAAGGAAAA",
										two_param_nuc_substitution_matrix,
										2,
										2);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("TAATGGATACCGGAATTAAGC", matrix->gappedSequenceA);
			Utilities::AreEqual("-AACGG-TAAAGGAA--AA--", matrix->gappedSequenceB);
			Assert::AreEqual(9, matrix->score);
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfB_Blosum) {
			matrix = nw_align_sequences("PAWHEAE",
										"HEAGAWGHEE",
										blosum50_substitution_matrix,
										8,
										8);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("HEAGAWGHE-E", matrix->gappedSequenceB);
			Utilities::AreEqual("--P-AW-HEAE", matrix->gappedSequenceA);
			Assert::AreEqual(1, matrix->score);
		}	
	
		TEST_METHOD(Test_SingleGapAtEndOfA) {
			matrix = nw_align_sequences("PHASTVM",
										"PHASTVMP",
										blosum50_substitution_matrix,
										8,
										8);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("PHASTVM-", matrix->gappedSequenceA);
			Utilities::AreEqual("PHASTVMP", matrix->gappedSequenceB);
			Assert::AreEqual(39, matrix->score);
			Assert::AreEqual(1.0, get_fraction_identity(matrix->gappedSequenceA,  matrix->gappedSequenceB), 0.0001);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfA) {
			matrix = nw_align_sequences("PHASTVM",
										"PHASTVMPQ",
										blosum50_substitution_matrix,
										8,
										8);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("PHASTVM--", matrix->gappedSequenceA);
			Utilities::AreEqual("PHASTVMPQ", matrix->gappedSequenceB);
			Assert::AreEqual(31, matrix->score);

		}

		TEST_METHOD(Test_2PGKSequencesFromFastaFiles) {
			
			char header[81];
			char porcine_sequence[1000];
			char yeast_sequence[1000];

			read_single_sequence_fasta_file(
				header, 
				porcine_sequence,
				R"(..\..\SampleData\ProteinSequences\porcine_pgk.fasta)"
			);
			
			read_single_sequence_fasta_file(
				header, 
				yeast_sequence,
				R"(..\..\SampleData\ProteinSequences\yeast_pgk.fasta)"
			);

			matrix = nw_align_sequences(
				yeast_sequence,
				porcine_sequence,
				blosum50_substitution_matrix,
				8,
				8);

			Utilities::AssertIsSane(matrix);

			Utilities::AreEqual(
				"MSLSSKLSVQDLDLKDKRVFIRVDFNVPLDGKKITSNQRIVAALPTIKYVLEHHPRYVVLASHLGRPNG-ERNEKYSLAP"
				"VAKELQSLLGKDVTFLNDCVGPEVEAAVKASAP-GSVILLENLRYHIEEEG-SRKVDGQKVKASKEDVQKFRHELSSLAD"
				"VYINDAFGTAHRAHSSMVGFDLPQRAAGFLLEKELKYFGKALENPTRPFLAILGGAKVADKIQLIDNLLDKVDSIIIGGG"
				"MAFTFKKVLENTEIGDSIFDKAGAEIVPKLMEKAKAKGVEVVLPVDFIIADAFSADANTKTVTDKEGIPAGWQGLDNGPE"
				"SRKLFAATVAKAKTIVWNGPPGVFEFEKFAAGTKALLDEVVKSSAAGNTVIIGGGDTATVAKKYGVTDKISHVSTGGGAS"
				"LELLEGKELPGVAFLSEKK", 
				matrix->gappedSequenceA);

			Utilities::AreEqual(
				"MSLSKKLTLDKLDVKGKRVIMRVDFNVPMKRNQVTNNQRIKASLPSIRYCLDNGARSVVLMSHLGRPDGVAMPDKYSLEP"
				"VAAELKSLLGKDVLFLKDCVGSEAEQAC-ANPPAGSVILLENLRFHVEEEGKGQDPSGNKLKAEPDKVEAFRASLSKLGD"
				"VYVNDAFGTAHRAHSSMVGVNLPQKASGFLMKKELDYFAKALENPERPFLAILGGAKVADKIQLIKNMLDKVNEMIIGGG"
				"MAFTFLKVLNNMEIGASLFDKEGATIVKEIMAKAEKNRVNITFPVDFVIADKFEENAKVGQATVASGIPAGWVALDCGPE"
				"TNKKYAQVVARAKLIVWNGPLGVFEWDAFANGTKALMDEIVKATSKGCITIIGGGDTATCCAKWNTEDKVSHVSTGGGAS"
				"LELLEGKVLPGVEALS-NL",
				matrix->gappedSequenceB);

			Assert::AreEqual(0.6418, get_fraction_identity(matrix->gappedSequenceA,  matrix->gappedSequenceB), 0.0001);

			Assert::AreEqual(1701, matrix->score);
		}
	};

}