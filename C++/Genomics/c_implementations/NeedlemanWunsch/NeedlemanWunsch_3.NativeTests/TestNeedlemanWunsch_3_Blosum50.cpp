#include "stdafx.h"
#include "CppUnitTest.h"

#include "TestUtilities.h"
#include "nw_matrix.h"
#include "sequence_utilities.h"
#include "substitution_matrix.h"
#include "fasta_reader.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using namespace TestUtilities;

namespace NeedlemanWunsch_3NativeTests
{		
	TEST_CLASS(TestNeedlemanWunsch_3_Blosum50)
	{
	public:

		private:

			nw_matrix_t* matrix;
			substitution_matrix_t* sm_matrix;

		public:

		TEST_METHOD_INITIALIZE(Initialize) {
			matrix = 0;
			 sm_matrix = create_blosum50_subs_matrix();
		}

		TEST_METHOD_CLEANUP(Cleanup) {
			if (matrix != 0) {
				nw_free_matrix(matrix);
			}

			if (sm_matrix != 0) {
				sm_delete(sm_matrix);
			}
		}

		TEST_METHOD(Test_MultipleGapsAtStartOfB) {
			matrix = nw_align_sequences("PAWHEAE", 
										"HEAGAWGHEE",
										sm_matrix,
										8);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("HEAGAWGHE-E", matrix->gappedSequenceB);
			Utilities::AreEqual("--P-AW-HEAE", matrix->gappedSequenceA);
			Assert::AreEqual(1, matrix->score);
		}	
	
		TEST_METHOD(Test_SingleGapAtEndOfA) {
			matrix = nw_align_sequences("PHASTVM",
										"PHASTVMP",
										sm_matrix,
										8);
			Utilities::AssertIsSane(matrix);
			Utilities::AreEqual("PHASTVM-", matrix->gappedSequenceA);
			Utilities::AreEqual("PHASTVMP", matrix->gappedSequenceB);
			Assert::AreEqual(39, matrix->score);
			Assert::AreEqual(100.0, 100 * get_fraction_identity(matrix->gappedSequenceA,  matrix->gappedSequenceB), 0.0001);
		}

		TEST_METHOD(Test_MultipleGapsAtEndOfA) {
			matrix = nw_align_sequences("PHASTVM",
										"PHASTVMPQ",
										sm_matrix,
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
				sm_matrix,
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