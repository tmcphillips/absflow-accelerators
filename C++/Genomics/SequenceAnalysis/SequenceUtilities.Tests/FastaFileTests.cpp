#include "stdafx.h"
#include "CppUnitTest.h"
#include "FastaFile.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;


namespace FastaFileTests
{		
	void AreEqual(const char * expected, BiologicalSequence actual) {
		Assert::AreEqual(expected, actual.str().c_str());
	};

	TEST_CLASS(FastaFileTests)
	{
	public:
		
		TEST_METHOD(TestReadSingleSequenceFastaFile)
		{
			FastaFile fastaFile(R"(..\..\SampleData\ProteinSequences\)"  "porcine_pgk.fasta");

			Assert::AreEqual(
				">gi|40647093|gb|AAR88362.1| phosphoglycerate kinase 2 [Sus scrofa]",
				fastaFile.getHeader().c_str());

			AreEqual(
				"MSLSKKLTLDKLDVKGKRVIMRVDFNVPMKRNQVTNNQRIKASLPSIRYCLDNGARSVVLMSHLGR"
				"PDGVAMPDKYSLEPVAAELKSLLGKDVLFLKDCVGSEAEQACANPPAGSVILLENLRFHVEEEGKG"
				"QDPSGNKLKAEPDKVEAFRASLSKLGDVYVNDAFGTAHRAHSSMVGVNLPQKASGFLMKKELDYFA"
				"KALENPERPFLAILGGAKVADKIQLIKNMLDKVNEMIIGGGMAFTFLKVLNNMEIGASLFDKEGAT"
				"IVKEIMAKAEKNRVNITFPVDFVIADKFEENAKVGQATVASGIPAGWVALDCGPETNKKYAQVVAR"
				"AKLIVWNGPLGVFEWDAFANGTKALMDEIVKATSKGCITIIGGGDTATCCAKWNTEDKVSHVSTGG"
				"GASLELLEGKVLPGVEALSNL", 
				*(fastaFile.sequence())
				);
		}

	};
}