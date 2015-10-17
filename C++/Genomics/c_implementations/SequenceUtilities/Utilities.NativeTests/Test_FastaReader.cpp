#include "stdafx.h"
#include "CppUnitTest.h"
#include "fasta_reader.h"
#include <direct.h>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UtilitiesNativeTests
{
	TEST_CLASS(Test_FastaReader)
	{
	public:
		
		TEST_METHOD(TestReadSingleSequenceFastaFile)
		{
			char header[81];
			char sequence[1000];

			_getcwd(header, 80);

			char* actual = read_single_sequence_fasta_file(
				header, 
				sequence,
				R"(..\..\SampleData\ProteinSequences\porcine_pgk.fasta)");

			Assert::AreEqual(
				">gi|40647093|gb|AAR88362.1| phosphoglycerate kinase 2 [Sus scrofa]",
				header );
			Assert::AreEqual(
				"MSLSKKLTLDKLDVKGKRVIMRVDFNVPMKRNQVTNNQRIKASLPSIRYCLDNGARSVVLMSHLGR"
				"PDGVAMPDKYSLEPVAAELKSLLGKDVLFLKDCVGSEAEQACANPPAGSVILLENLRFHVEEEGKG"
				"QDPSGNKLKAEPDKVEAFRASLSKLGDVYVNDAFGTAHRAHSSMVGVNLPQKASGFLMKKELDYFA"
				"KALENPERPFLAILGGAKVADKIQLIKNMLDKVNEMIIGGGMAFTFLKVLNNMEIGASLFDKEGAT"
				"IVKEIMAKAEKNRVNITFPVDFVIADKFEENAKVGQATVASGIPAGWVALDCGPETNKKYAQVVAR"
				"AKLIVWNGPLGVFEWDAFANGTKALMDEIVKATSKGCITIIGGGDTATCCAKWNTEDKVSHVSTGG"
				"GASLELLEGKVLPGVEALSNL",
				sequence);
		}

	};
}