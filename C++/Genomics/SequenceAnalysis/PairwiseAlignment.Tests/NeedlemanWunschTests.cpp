#include "stdafx.h"
#include "CppUnitTest.h"
#include <Windows.h>
#include "NeedlemanWunsch.h"
#include "AlignmentModel.h"
#include "FastaFile.h"

#include <sstream>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;
using std::string;
using std::stringstream;

namespace NeedlemanWunschTests
{
	void writeToClipboard(string text) {
		if (!OpenClipboard(NULL)) throw "Cannot open the Clipboard";
		if (!EmptyClipboard()) throw "Cannot empty the Clipboard";
		int textSize = text.size() + 1;
		HGLOBAL hGlob = GlobalAlloc(GMEM_FIXED, textSize);
		if (hGlob == NULL) throw "Cannot allocate memory";
		strcpy_s((char*) hGlob, textSize, text.c_str());
		if (::SetClipboardData(CF_TEXT, hGlob) == NULL) throw "Error setting clipboard data";
		GlobalFree(hGlob);
		CloseClipboard();
	}

	void AreEqual(const char * expected, string actual) {
		Assert::AreEqual(expected, actual.c_str());
	};

	void AreEqual(const char * expected, BiologicalSequence actual) {
		AreEqual(expected, actual.str());
	};

	void AreEqual(string expected, string actual) {
		Assert::AreEqual(expected, actual);
	};

	void AreEqual(NeedlemanWunsch::nwCell expected, NeedlemanWunsch::nwCell actual) {
		Assert::AreEqual(expected.best, actual.best);
		Assert::AreEqual(expected.gap_a, actual.gap_a);
		Assert::AreEqual(expected.gap_b, actual.gap_b);
		Assert::AreEqual(expected.back_vector.di, actual.back_vector.di);
		Assert::AreEqual(expected.back_vector.dj, actual.back_vector.dj);
	};

	void AreEqual(BiologicalSequence expected, BiologicalSequence actual) {
		AreEqual(expected.str(), actual.str());
	};

	void AssertSane(NeedlemanWunsch nw, AlignedSequencePair asp) {

		auto alignedSeqA = asp.first;
		auto alignedSeqB = asp.second;

		// make sure two gapped sequences have the same length
		Assert::AreEqual(alignedSeqA.length(), alignedSeqB.length());

		// make the sure the gapped sequences are the same as the original sequences when gaps are removed
		AreEqual(nw.seqa, alignedSeqA.ungapped());

		// make the sure the gapped sequences are the same as the original sequences when gaps are removed
		AreEqual(nw.seqb, alignedSeqB.ungapped());

		Assert::AreEqual(nw.score(), asp.score());
	}

	void AssertSane(NeedlemanWunsch nw, PairwiseAlignment alignment) {
		for (auto alignedPair : alignment) {
			AssertSane(nw, alignedPair);
		}
	}

	TEST_CLASS(NeedlemanWunschTests)
	{
	public:

		TEST_METHOD(Test_Constructor_MatrixDimensions)
		{
			auto nw = NeedlemanWunsch{ "ATTAAG", "AATCTAGC", twoParamNucleotideModel(2,-1,2,1)};
			AreEqual("ATTAAG", nw.seqa);
			AreEqual("AATCTAGC", nw.seqb);
		}

		TEST_METHOD(Test_Constructor_TopRows) {

			auto nw = NeedlemanWunsch{ "ATTAAG", "AATCTAGC", twoParamNucleotideModel(2, -1, 2, 1) };

			Assert::AreEqual( 0, nw.f(0, 0));
			Assert::AreEqual(-2, nw.f(0, 1));
			Assert::AreEqual(-3, nw.f(0, 2));
			Assert::AreEqual(-4, nw.f(0, 3));
			Assert::AreEqual(-5, nw.f(0, 4));
			Assert::AreEqual(-6, nw.f(0, 5));
			Assert::AreEqual(-7, nw.f(0, 6));
		}

		TEST_METHOD(Test_Constructor_LeftColumns) {

			auto nw = NeedlemanWunsch{ "ATTAAG", "AATCTAGC", twoParamNucleotideModel(2, -1, 2, 1) };

			Assert::AreEqual( 0, nw.f(0, 0));
			Assert::AreEqual(-2, nw.f(1, 0));
			Assert::AreEqual(-3, nw.f(2, 0));
			Assert::AreEqual(-4, nw.f(3, 0));
			Assert::AreEqual(-5, nw.f(4, 0));
			Assert::AreEqual(-6, nw.f(5, 0));
			Assert::AreEqual(-7, nw.f(6, 0));
			Assert::AreEqual(-8, nw.f(7, 0));
			Assert::AreEqual(-9, nw.f(8, 0));
		}

		TEST_METHOD(Test_3x2_ZeroGapCost)
		{
			auto nw = NeedlemanWunsch{ "ATC", "TC", twoParamNucleotideModel(1, 0, 0, 0) };

			AreEqual("ATC", nw.seqa);
			AreEqual("TC", nw.seqb);

			Assert::AreEqual(0, nw.f(0, 0));
			Assert::AreEqual(0, nw.f(0, 1));
			Assert::AreEqual(0, nw.f(0, 2));
			Assert::AreEqual(0, nw.f(0, 3));
			Assert::AreEqual(0, nw.f(1, 0));
			Assert::AreEqual(0, nw.f(2, 0));

			auto alignment = nw.align();

			Assert::AreEqual(0, nw.f(1, 1));
			Assert::AreEqual(1, nw.f(1, 2));
			Assert::AreEqual(1, nw.f(1, 3));
			Assert::AreEqual(0, nw.f(2, 1));
			Assert::AreEqual(1, nw.f(2, 2));
			Assert::AreEqual(2, nw.f(2, 3));

			AssertSane(nw, alignment);

			AreEqual("ATC", alignment.front().first);
			AreEqual("-TC", alignment.front().second);
		}

		struct test_data { string seqa; string seqb; int score; string gapped_seqa; string gapped_seqb; };

		void TwoParamNucleotideModel_TestHelper(int gap_open_cost, int gap_extension_cost, std::vector<test_data> data) {
			auto model = twoParamNucleotideModel(2, -1, gap_open_cost, gap_extension_cost);
			for (auto d : data) {
				auto nw = NeedlemanWunsch(d.seqa, d.seqb, model);
				auto alignment = nw.align();
				AssertSane(nw, alignment);
				AreEqual(d.gapped_seqa, alignment.front().first);
				AreEqual(d.gapped_seqb, alignment.front().second);
				Assert::AreEqual(d.score, nw.score());
			}
		}

		void Blosum50ProteinModel_TestHelper(int gap_open_cost, int gap_extension_cost, std::vector<test_data> data) {
			auto model = blosum50ProteinModel(gap_open_cost, gap_extension_cost);
			for (auto d : data) {
				auto nw = NeedlemanWunsch(d.seqa, d.seqb, model);
				auto alignment = nw.align();
				AssertSane(nw, alignment);
				AreEqual(d.gapped_seqa, alignment.front().first);
				AreEqual(d.gapped_seqb, alignment.front().second);
				Assert::AreEqual(d.score, nw.score());
			}
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_ZeroGapCost_GapsAtOneEnd) {
			TwoParamNucleotideModel_TestHelper(0, 0, {
				{ "TTT",	"TTT",		6,	"TTT",		"TTT"  },
				{ "ATTT",	"TTT",		6,	"ATTT",		"-TTT" },
				{ "AATTT",	"TTT",		6,	"AATTT",	"--TTT" },
				{ "AAATTT",	"TTT",		6,	"AAATTT",	"---TTT" },
				{ "TTTA",	"TTT",		6,	"TTTA",		"TTT-" },
				{ "TTTAA",	"TTT",		6,	"TTTAA",	"TTT--" },
				{ "TTT",	"ATTT",		6,	"-TTT",		"ATTT" },
				{ "TTT",	"AATTT",	6,	"--TTT",	"AATTT" },
				{ "TTT",	"TTTA",		6,	"TTT-",		"TTTA" },
				{ "TTT",	"TTTAA",	6,	"TTT--",	"TTTAA" },
				{ "TTT",	"TTTAAA",	6,	"TTT---",	"TTTAAA" },
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_LinearGapCost_GapsAtOneEnd) {
			TwoParamNucleotideModel_TestHelper(2, 2, {
				{ "TTT",	"TTT",		6,	"TTT",		"TTT" },
				{ "ATTT",	"TTT",		4,	"ATTT",		"-TTT" },
				{ "AATTT",	"TTT",		2,	"AATTT",	"--TTT" },
				{ "AAATTT",	"TTT",		0,	"AAATTT",	"---TTT" },
				{ "TTTA",	"TTT",		4,	"TTTA",		"TTT-" },
				{ "TTTAA",	"TTT",		2,	"TTTAA",	"TTT--" },
				{ "TTT",	"ATTT",		4,	"-TTT",		"ATTT" },
				{ "TTT",	"AATTT",	2,	"--TTT",	"AATTT" },
				{ "TTT",	"TTTA",		4,	"TTT-",		"TTTA" },
				{ "TTT",	"TTTAA",	2,	"TTT--",	"TTTAA" },
				{ "TTT",	"TTTAAA",	0,	"TTT---",	"TTTAAA" },
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_AffineGapCost_GapsAtOneEnd) {
			TwoParamNucleotideModel_TestHelper(2, 1, {
				{ "TTT",	"TTT",		6,	"TTT",		"TTT" },
				{ "ATTT",	"TTT",		4,	"ATTT",		"-TTT" },
				{ "AATTT",	"TTT",		3,	"AATTT",	"--TTT" },
				{ "AAATTT",	"TTT",		2,	"AAATTT",	"---TTT" },
				{ "TTTA",	"TTT",		4,	"TTTA",		"TTT-" },
				{ "TTTAA",	"TTT",		3,	"TTTAA",	"TTT--" },
				{ "TTT",	"ATTT",		4,	"-TTT",		"ATTT" },
				{ "TTT",	"AATTT",	3,	"--TTT",	"AATTT" },
				{ "TTT",	"TTTA",		4,	"TTT-",		"TTTA" },
				{ "TTT",	"TTTAA",	3,	"TTT--",	"TTTAA" },
				{ "TTT",	"TTTAAA",	2,	"TTT---",	"TTTAAA" },
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_ZeroGapCost_GapsInMiddle) {
			TwoParamNucleotideModel_TestHelper(0, 0, {
				{ "TTT", "TATT",	6, "T-TT",		"TATT" },
				{ "TTT", "TTAAT",	6, "TT--T",		"TTAAT" },
				{ "TTT", "TATAT",	6, "T-T-T",		"TATAT" },
				{ "TTT", "TAATAT",	6, "T--T-T",	"TAATAT" },
				{ "TATT", "TTT",	6, "TATT",		"T-TT" },
				{ "TTAAT", "TTT",	6, "TTAAT",		"TT--T" },
				{ "TATAT", "TTT",	6, "TATAT",		"T-T-T" },
				{ "TAATAT", "TTT",	6, "TAATAT",	"T--T-T" },
				{ "TTTAT", "TATTT", 8, "T-TTAT",	"TATT-T" }
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_LinearGapCost_GapsInMiddle) {
			TwoParamNucleotideModel_TestHelper(2, 2, {
				{ "TTT", "TATT",	4, "T-TT",		"TATT" },
				{ "TTT", "TTAAT",	2, "TT--T",		"TTAAT" },
				{ "TTT", "TATAT",	2, "T-T-T",		"TATAT" },
				{ "TTT", "TAATAT",	0, "T--T-T",	"TAATAT" },
				{ "TATT", "TTT",	4, "TATT",		"T-TT" },
				{ "TTAAT", "TTT",	2, "TTAAT",		"TT--T" },
				{ "TATAT", "TTT",	2, "TATAT",		"T-T-T" },
				{ "TAATAT", "TTT",	0, "TAATAT",	"T--T-T" }
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_AffineGapCost_GapsInMiddle) {
			TwoParamNucleotideModel_TestHelper(2, 1, {
				{ "TTT", "TATT",	4, "T-TT",		"TATT" },
				{ "TTT", "TTAAT",	3, "TT--T",		"TTAAT" },
				{ "TTT", "TATAT",	2, "T-T-T",		"TATAT" },
				{ "TTT", "TAATAT",	1, "T--T-T",	"TAATAT" },
				{ "TATT", "TTT",	4, "TATT",		"T-TT" },
				{ "TTAAT", "TTT",	3, "TTAAT",		"TT--T" },
				{ "TATAT", "TTT",	2, "TATAT",		"T-T-T" },
				{ "TAATAT", "TTT",	1, "TAATAT",	"T--T-T" }
			});
		}

		TEST_METHOD(Test_TwoParamNucleotideModel_LinearGapCost_General) {
			TwoParamNucleotideModel_TestHelper(2, 2, {
				{ "ATGGCTTGAGC",	"ATTGCTTAAGC",				16, "ATGGCTTGAGC", 
																	"ATTGCTTAAGC" },

				{ "ATCGGAGGC",		"ATTCTTAAGC",				7,	"A-TCGGAGGC", 
																	"ATTCTTAAGC" },

				{ "ATTGGAGAGC",		"ATTCTAAGC",				10,	"ATTGGAGAGC",
																	"ATTCTA-AGC" },

				{ "TTCTAAGC",		"ATTCTAGC",					10, "-TTCTAAGC", 
																	"ATTCT-AGC" },

				{ "TAATGGA",		"AACGGTA",					5,	"TAATGG-A",
																	"-AACGGTA" },

				{ "ATTAAGC",		"AATCTAG",					2,	"-ATTAAGC",
																	"AATCTAG-" },

				{ "TAATGGATACCGGAA", "CCTTAAGGAACGGTAAAGGAA",	6,	"---TAATG---GATACCGGAA", 
																	"CCTTAAGGAACGGTAAAGGAA" },

				{ "AATTAAGGTATCCTAATGCCATA", "CCTAATGGATA",		-5,	"AATTAAGGTATCCTAATGCCATA",
																	"-----------CCTAATG-GATA" },

				{ "TAATGGATACCGGAATTAAGC", "AACGGTAAAGGAAAA",	9,	"TAATGGATACCGGAATTAAGC", 
																	"-AACGG-TAAAGGAA--AA--" }
			});
		}


		TEST_METHOD(Test_TwoParamNucleotideModel_AffineGapCost_General) {
			TwoParamNucleotideModel_TestHelper(2, 1, {
			
				{ "ATTAAG", "AATCTAGC",			2,	"-AT-TAAG", 
													"AATCTAGC" },
				
				{ "ATGGCTTGAGC", "ATTGCTTAAGC",	16, "ATGGCTTGAGC",
													"ATTGCTTAAGC" },

				{ "ATCGGAGGC", "ATTCTTAAGC",	7,	"A-TCGGAGGC",
													"ATTCTTAAGC" },

				{ "ATTGGAGAGC", "ATTCTAAGC",	10, "ATTGGAGAGC",
													"ATTCTA-AGC" },

				{ "TTCTAAGC", "ATTCTAGC",		10, "-TTCTAAGC",
													"ATTCT-AGC" },

				{ "TAATGGA", "AACGGTA",			5,	"TAATGG-A",
													"-AACGGTA" },
											
				{ "ATTAAGC", "AATCTAG",			2,	"-ATTAAGC",
													"AATCTAG-" },

				{ "TAATGGA", "CCTTAAGGAA",		4,	"---TAATGGA",
													"CCTTAAGGAA" },
																	
				{ "TGGA", "GGAAC",				1,	"TGGA--",
													"-GGAAC" },

				{ "TAATGGATACCGGAA", "CCTTAAGGAACGGTAAAGGAA",	11, "---TAATGGA----TACCGGAA",
																	"CCTTAA-GGAACGGTAAAGGAA" },
			});
		}

		TEST_METHOD(TestBlosum50ProteinModel_LinearGapCost) {
			Blosum50ProteinModel_TestHelper(8, 8, {
				{ "PHASTVM", "PHASTVMP", 39,	"PHASTVM-",
												"PHASTVMP" },

				{ "PHASTVM", "PHASTVMPQ", 31,	"PHASTVM--", 
												"PHASTVMPQ" },

				{ "PAWHEAE", "HEAGAWGHEE", 1,	"--P-AW-HEAE", 
												"HEAGAWGHE-E" },

				{ "HEAGAWGHEE", "PAWHEAE", 1,	"HEAGAWGHE-E", 
												"--P-AW-HEAE" }

			});
		}


		TEST_METHOD(TestBlosum62ProteinModel_LinearGapCost) {

			auto model = blosum62ProteinModel(5, 5);
			auto nw = NeedlemanWunsch("PLEASANTLY", "MEANLY", model);
			auto alignment = nw.align();
			AssertSane(nw, alignment);
			//AreEqual(d.gapped_seqa, alignment.front().first);
			//AreEqual(d.gapped_seqb, alignment.front().second);
			Assert::AreEqual(8, nw.score());
			string result = std::to_string(nw.score()) + "\r\n" +
				alignment.front().first.str() + "\r\n" +
				alignment.front().second.str() + "\r\n";

			writeToClipboard(result);
		}

		TEST_METHOD(TestBlosum62ProteinModel_LinearGapCost_Quiz) {

			auto model = blosum62ProteinModel(5, 5);
			string a = "HAPHIFPMWRSQDCYKFEVGHRDNVCPIREGKPYIAKCVTTKCMDNDETHDLIKQLPRNWFVADFKDGGELPCPTCPNLVKVHVRLVMADIITADYNFGTAQPKWDSCQPYASCFWFPVKIVKWTRGVPKGYENRGRCDEVALHQQWKTPFFDIVPVEYLFSPWLRPGENVKASLHSDMNVREWYAFTMHLVVSAQMHYRHFCQDWWSRKYRRNDCVNHFYLCMAGRIYDATNFYTHVRDQMTEFMWKFLAYIWELMILLWSHMLFPSVYMQLLTRSIEQNAFSDPCLFPLHRHAWETMLRGFQPKGSAMLNYFDCPNELMATSHTITVPSYSYMITHCKRVPAGNIQAQHDVPICFYEIPRRGYCQPRYNREQIHPRWFNPPPGWPTEEPRKTAYAGTTHAQHGHKEMESWYCPIGPMFMEMCYLRIYVDRVRGVMIRVTVNQHFGQTYVKAHGRKEMEQGHVNMSCKEYEEVWNGPEKCRFNWKSNVKINYRIARSALTEGVQLFHHDSPRLEAGHHMMVPNDMWWEWMEMVCQGSTMPLLNAKPFHHYKPVMMRLIVERPEWTHCQYPCPFWIATWWISCGEDPWGWTYLPHGSFFGHVEHYEKNVNRYKQSRLPAHKWIRMFDCLWLITFLFVVTDCMLNYVYHQGQALKEGTNTRSQHQGLNAGPARDCYLDCYDQEMHSIEHYYMCYWVPTVNGMSCCHKDDDCQPDKLDECQHLFNMCTSGKYIQYGQVFIMSVYAQQDHSFQSQFWPIAWHTVCRHDEPGSPLCYCKDCHQAEDISGLWPAWTDDASYNWEHSNRGNNLNSQEGTFHFMPEPCDFLHMPHCYMPREPAAPYMPGYCAP";
			string b = "HAPHIFPMWRSQDSYDNVCPIRYIAKCVTTKCMDQDETHDLIKQLIRNWFVFCGGGLPCPTKPNLVKVHVKLVMACIITCDYNFYTNMKPKWDSCLGPWRPYASCLELTGCTFPVKIVKWTSGVWPTGIMDEVALHQQWKTPFFDEYLFSPKNKMLPPGGNIYWPFYDKASLHSDMNVREWYAFTMHLVVSAFMHYRHFCSDWWSRKYRRNDCLYISQLKNDFYACMAVHVRDWYNWTTHFMWKFLAYIIEQMILLWSHMLSPSNYMQLLTDWFLLVMSIEQNAFSDPCLFPLHRSAIETKLRLGKLRDFQPVWCSAMLNGEVCPPFEAGNHHELMATSHTITVPSYSYHIEVPKGNIYMEEAQHDVPICFYEIDRRRLLVPYCQPRYNREQIHPRWFNPNPGWPTEESMAQHGHSERESAYCPIYSCQHNQHFDTWTMCETYVKAHGRKQMEQYEEVTYFHHSTYNWNSNVKIEYRIARSALTEGVQLFHHDSPSLDAGHHMMVPNDMWWEWMEMVCPGSTTLQLPLLVVEGMQKPFHHYIYYERPTWTHCQYPCPFWIATWWIRPWGWTNLPHGDVPFFGKFGHYEKNPNGCFEEYFWGEIDWLRLPAHKWINMFDCTWLITFLFHVTVHTLLGKMLNYVYHQGQALKEGWNGQHAHAHFYGCCYDQYMHSIEVPCEMGSYMCYWVPEDCAYADFAVNGMSCCHKDDDCQPDKLDECQHLYIFHHIVNMCTSGKMIQFVQPYCDLIMSVYAQQDHSFQCATMQFWPIQWHTVCRHEEGSPLCYEDISGLWPAWTDDASYNWESNRGCNLNSQEGQKIGHIMFCREYLQFMTMMSMHKEWTCYKCDLNCYEPNEPAAPYMPGYCYP";

			auto nw = NeedlemanWunsch(a, b, model);
			auto alignment = nw.align();
			AssertSane(nw, alignment);
			AreEqual(
				"HAPHIFPMWRSQDCYKFEVGHRDNVCPIREGKPYIAKCVTTKCMDNDETHDLIKQLPRNWFVADFKDGGELPCPTCPNLVKVHVRLVMADIITADYNFGT-AQPKWDSC----QPYASC--F---WFPVKIVKWTRGVPKGYENRGRCDEVALHQQWKTPFFDIVPVEYLFSP---WLRPGENV------KASLHSDMNVREWYAFTMHLVVSAQMHYRHFCQDWWSRKYRRNDCVNHFYLCMAGRIYDATNFYTHVRD--Q-MTEFMWKFLAYIWELMILLWSHMLFPSVYMQLLT------RSIEQNAFSDPCLFPLHRHAWETMLR-G----FQPKG-SAMLNYFDC-P----N--ELMATSHTITVPSYSYMITHCKRVPAGNI---QAQHDVPICFYEIP-RR---GYCQPRYNREQIHPRWFNPPPGWPTEEPRKTAYAGTTHAQHGHKEMESWYCPIGPMFMEMCYLRIYVDRVRGVMIRVTVNQHFGQTYVKAHGRKEMEQGHVNMSCKEYEEVWNGPEKCRFNWKSNVKINYRIARSALTEGVQLFHHDSPRLEAGHHMMVPNDMWWEWMEMVCQGS-T--MPLL--NA--KPFHHYKPVMMRLIVERPEWTHCQYPCPFWIATWWISCGEDPWGWTYLPHGS--FFGHVEHYEKNVN----RY--KQ-S--RLPAHKWIRMFDCLWLITFLF-V-V-T--DCMLNYVYHQGQALKEGTNTRSQHQGLNAGPARDCYLDCYDQEMHSIE---HY--YMCYWVP--------TVNGMSCCHKDDDCQPDKLDECQHL--F----NMCTSGKYIQYGQVF---IMSVYAQQDHSFQ--S-QFWPIAWHTVCRHDEPGSPLCYCKDCHQAEDISGLWPAWTDDASYNWEHSNRGNNLNSQEG-TF-H--FMPEPCDFL-HMP-H----CY---M----PREPAAPYMPGYCAP", 
				alignment.front().first);
			
			AreEqual("HAPHIFPMWRSQDSY-------DNVCPIR----YIAKCVTTKCMDQDETHDLIKQLIRNWFV--FCGGG-LPCPTKPNLVKVHVKLVMACIITCDYNFYTNMKPKWDSCLGPWRPYASCLELTGCTFPVKIVKWTSGV---WPT-GIMDEVALHQQWKTPFFD----EYLFSPKNKMLPPGGNIYWPFYDKASLHSDMNVREWYAFTMHLVVSAFMHYRHFCSDWWSRKYRRNDCL-YISQ-LKNDFY-AC-MAVHVRDWYNWTTHFMWKFLAYIIEQMILLWSHMLSPSNYMQLLTDWFLLVMSIEQNAFSDPCLFPLHRSAIETKLRLGKLRDFQPVWCSAMLNGEVCPPFEAGNHHELMATSHTITVPSYSY---HIE-VPKGNIYMEEAQHDVPICFYEIDRRRLLVPYCQPRYNREQIHPRWFNPNPGWPTEE--------SM-AQHGHSERESAYCPI---Y-S-C--Q-H-NQ-H---FD-TWTM-C-ETYVKAHGRKQMEQ---------YEEV-TYFHHSTYNWNSNVKIEYRIARSALTEGVQLFHHDSPSLDAGHHMMVPNDMWWEWMEMVCPGSTTLQLPLLVVEGMQKPFHHY--I----YYERPTWTHCQYPCPFWIATWWI---R-PWGWTNLPHGDVPFFGKFGHYEKNPNGCFEEYFWGEIDWLRLPAHKWINMFDCTWLITFLFHVTVHTLLGKMLNYVYHQGQALKEGWN--GQH-A-HA-HFYGC---CYDQYMHSIEVPCEMGSYMCYWVPEDCAYADFAVNGMSCCHKDDDCQPDKLDECQHLYIFHHIVNMCTSGKMIQFVQPYCDLIMSVYAQQDHSFQCATMQFWPIQWHTVCRHEE-GSPLCY-------EDISGLWPAWTDDASYNWE-SNRGCNLNSQEGQKIGHIMFCREYLQFMTMMSMHKEWTCYKCDLNCYEPNEPAAPYMPGYCYP", 
				alignment.front().second);
			
			Assert::AreEqual(2411, nw.score());
			string result = std::to_string(nw.score()) + "\r\n" +
				alignment.front().first.str() + "\r\n" +
				alignment.front().second.str() + "\r\n";

			writeToClipboard(result);
		}

		TEST_METHOD(TestAffineGapPenalty_PGK_LinearPenalty)
		{
			FastaFile yeast_pgk(R"(..\..\SampleData\ProteinSequences\yeast_pgk.fasta)");
			FastaFile porcine_pgk(R"(..\..\SampleData\ProteinSequences\porcine_pgk.fasta)");

			auto nw = NeedlemanWunsch(
				yeast_pgk.sequence(),
				porcine_pgk.sequence(),
				blosum50ProteinModel(8,8));

			auto alignment = nw.align();
			AssertSane(nw, alignment);

			AreEqual(
				"MSLSSKLSVQDLDLKDKRVFIRVDFNVPLDGKKITSNQRIVAALPTIKYVLEHHPRYVVLASHLGRPNG-ERNEKYSLAP"
				"VAKELQSLLGKDVTFLNDCVGPEVEAAVKASAP-GSVILLENLRYHIEEEG-SRKVDGQKVKASKEDVQKFRHELSSLAD"
				"VYINDAFGTAHRAHSSMVGFDLPQRAAGFLLEKELKYFGKALENPTRPFLAILGGAKVADKIQLIDNLLDKVDSIIIGGG"
				"MAFTFKKVLENTEIGDSIFDKAGAEIVPKLMEKAKAKGVEVVLPVDFIIADAFSADANTKTVTDKEGIPAGWQGLDNGPE"
				"SRKLFAATVAKAKTIVWNGPPGVFEFEKFAAGTKALLDEVVKSSAAGNTVIIGGGDTATVAKKYGVTDKISHVSTGGGAS"
				"LELLEGKELPGVAFLSEKK",
				alignment.front().first
			);

			AreEqual(
				"MSLSKKLTLDKLDVKGKRVIMRVDFNVPMKRNQVTNNQRIKASLPSIRYCLDNGARSVVLMSHLGRPDGVAMPDKYSLEP"
				"VAAELKSLLGKDVLFLKDCVGSEAEQAC-ANPPAGSVILLENLRFHVEEEGKGQDPSGNKLKAEPDKVEAFRASLSKLGD"
				"VYVNDAFGTAHRAHSSMVGVNLPQKASGFLMKKELDYFAKALENPERPFLAILGGAKVADKIQLIKNMLDKVNEMIIGGG"
				"MAFTFLKVLNNMEIGASLFDKEGATIVKEIMAKAEKNRVNITFPVDFVIADKFEENAKVGQATVASGIPAGWVALDCGPE"
				"TNKKYAQVVARAKLIVWNGPLGVFEWDAFANGTKALMDEIVKATSKGCITIIGGGDTATCCAKWNTEDKVSHVSTGGGAS"
				"LELLEGKVLPGVEALS-NL",
				alignment.front().second
			);

			Assert::AreEqual(0.6403, alignment.front().fractionIdentity(), 0.0001);
			Assert::AreEqual(1701, nw.score());

		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_ZeroPenalty)
		{
			FastaFile human_phc(R"(..\..\SampleData\ProteinSequences\human_phc.fasta)");
			FastaFile chicken_phc(R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)");

			auto nw = NeedlemanWunsch(
				human_phc.sequence(), 
				chicken_phc.sequence(),
				blosum50ProteinModel(0, 0));
			
			auto alignment = nw.align();
			AssertSane(nw, alignment);

			stringstream ss;
			ss << alignment.front();

			AreEqual(
				string(
				"ALLLQPLLGAQGAP-LEPVYPGDNATP-EQM-AQ-YAAD-LRRYINMLTRPRYGKRHKEDTLAF\n"
				"           | |  :| ||||:| | | :  : |  | |::|:|::|      ||:     :\n"
				"-----------G-PS-QPTYPGDDA-PVEDLI-RFY--DNLQQYLNVVT------RHR-----Y\n"),
				ss.str());
		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_LinearPenalty)
		{
			FastaFile human_phc(R"(..\..\SampleData\ProteinSequences\human_phc.fasta)");
			FastaFile chicken_phc(R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)");

			auto nw = NeedlemanWunsch(
				human_phc.sequence(), 
				chicken_phc.sequence(), 
				blosum50ProteinModel(8, 8));

			auto alignment = nw.align();
			AssertSane(nw, alignment);

			stringstream ss;
			ss << alignment.front();

			AreEqual(
				string(
				"ALLLQPLLGAQGAPLEPVYPGDNATPEQMAQYAADLRRYINMLTRPRYGKRHKEDTLAF\n"
				"     |   :|     | ||||:|  | : ::  :|::|:|::|      ||:     :\n"
				"G----P---SQ-----PTYPGDDAPVEDLIRFYDNLQQYLNVVT------RHR-----Y\n"),
				ss.str());
		}

		TEST_METHOD(TestAffineGapPenalty_PancreaticHormonePrecursors_AffinePenalty)
		{
			FastaFile human_phc(R"(..\..\SampleData\ProteinSequences\human_phc.fasta)");
			FastaFile chicken_phc(R"(..\..\SampleData\ProteinSequences\chicken_phc.fasta)");
			
			auto nw = NeedlemanWunsch(
				human_phc.sequence(), 
				chicken_phc.sequence(), 
				blosum50ProteinModel(10, 1));

			auto alignment = nw.align();
			AssertSane(nw, alignment);

			stringstream ss;
			ss << alignment.front();

			AreEqual(
				string(
				"ALLLQPLLGAQGAPLEPVYPGDNATPEQMAQYAADLRRYINMLTRPRYGKRHKEDTLAF\n"
				"             | :| ||||:|  | : ::  :|::|:|::|| ||           \n"
				"------------GPSQPTYPGDDAPVEDLIRFYDNLQQYLNVVTRHRY-----------\n"),
				ss.str());
		}
	};

}