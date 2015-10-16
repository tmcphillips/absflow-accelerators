#include <windows.h>
#include "CppUnitTest.h"
#include <vector>
#include <string>
#include <set>
#include <map>
#include <algorithm>

#include "Utilities.h"

using std::string;
using std::vector;
using std::set;
using std::pair;
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace MostFrequentKmersTests
{
	//Frequent Words Problem : Find the most frequent kmers in a string.
	//  Input : A string Text and an integer k.
	//	Output : All most frequent kmers in Text.
	//
	
	//	A	01000_00_1		(b & 0x06) >> 1 == 0x00
	//	a	01100_00_1

	//	C	01000_01_1		(b & 0x06) >> 1 == 0x01
	//	c	01100_01_1
	
	//	T	01010_10_0		(b & 0x06) >> 1 == 0x02
	//	t	01110_10_0

	//  G	01000_11_1		(b & 0x06) >> 1 == 0x03
	//	g	01100_11_1



	TEST_CLASS(MostFrequentKmersHistogram_Tests)
	{
		pair<vector<unsigned char>, size_t> encodeSequence(vector<char> sequence) {
			size_t encodedLength = (size_t) ceil(sequence.size() / 4.0);
			vector<unsigned char> encodedSequence(encodedLength);
			unsigned char * pCodeWord = &encodedSequence[0];
			int codeShift = 6;
			int const asciiMask = 0x06;
			for (char base : sequence) {
				unsigned char baseCode = (base & asciiMask) >> 1;
				*pCodeWord |= (baseCode << codeShift);
				if ((codeShift -= 2) < 0) {
					codeShift = 6;
					pCodeWord++;
				}
			}
			return pair<vector<unsigned char>,size_t> {encodedSequence, sequence.size()};
		}

		vector<char> decodeSequence(vector<unsigned char> encodedSequence, size_t size) {
			static char const baseForCode [] = { 'A', 'C', 'T', 'G' };
			vector<char> sequence(size);
			unsigned char * pCodeWord = &encodedSequence[0];
			int codeShift = 6; 
			int const codeMask = 0x03;
			char * pBase = &sequence[0];
			for (auto i = 0; i < size; ++i) {
				unsigned char code = (*pCodeWord >> codeShift) & codeMask;
				*pBase++ = baseForCode[code];
				if ((codeShift -= 2) < 0) {
					codeShift = 6;
					pCodeWord++;
				}
			}
			return sequence;
		}

		//set<string> mostFrequentKmers(pair<vector<unsigned char>, size_t> encodedSequence, size_t k) {

		//	size_t histogramSize = 2 << (2 * k);
		//	vector<size_t> histogram(histogramSize);

		//	// scan text for kmer with greatest count using a k-wide sliding window
		//	int maxCount = 0;
		//	int windowCount = encodedSequence.second - k + 1;
		//	for (unsigned windowStart = 0; windowStart < windowCount; windowStart++) {

		//		// at each position of window increment count of kmer in window
		//		string kmer = text.substr(windowStart, k);
		//		auto count = ++kmerCounts[kmer];

		//		// keep track of greatest count
		//		if (count > maxCount) maxCount = count;
		//	}

		//	// create an empty set of strings to hold most frequent kmers
		//	std::set<string> kmerSet;

		//	// iterate through kmer counts
		//	for (auto k : kmerCounts) {

		//		// add each kmer with count==max to the set
		//		if (k.second == maxCount)  kmerSet.insert(k.first);
		//	}

		//	// return the set
		//	return kmerSet;
		//}

		string encodeThenDecodeSequence(string sequence) {
			vector<char> s(begin(sequence), end(sequence));
			auto encodedPair = encodeSequence(s);
			auto ds = decodeSequence(encodedPair.first, encodedPair.second);
			return string(begin(ds), end(ds));
		}

	public:

		TEST_METHOD(TestEncodeSequence_OneEncodedByte) {
			vector<char> s{ 'A', 'C', 'T', 'G' };
			auto es = encodeSequence(s).first;
			Assert::AreEqual((unsigned char)0x1b, es[0]);
		}

		TEST_METHOD(TestEncodeSequence_TwoEncodedBytes) {
			vector<char> s{ 'A', 'C', 'T', 'G', 'A', 'C', 'T', 'G' };
			auto es = encodeSequence(s).first;
			Assert::AreEqual((unsigned char) 0x1b, es[0]);
			Assert::AreEqual((unsigned char) 0x1b, es[1]);
		}

		TEST_METHOD(TestDecodeSequence_OneEncodedByte) {
			vector<unsigned char> es{ 0x1b };
			auto ds = decodeSequence(es, 4);
			Assert::AreEqual('A', ds[0]);
			Assert::AreEqual('C', ds[1]);
			Assert::AreEqual('T', ds[2]);
			Assert::AreEqual('G', ds[3]);
		}

		TEST_METHOD(TestEncodeThenDecodeSequence_OneBase) {
			string s("T");
			Assert::AreEqual(s, encodeThenDecodeSequence(s));
		}

		TEST_METHOD(TestEncodeThenDecodeSequence_ThreeBases) {
			string s("TAG");
			Assert::AreEqual(s, encodeThenDecodeSequence(s));
		}

		TEST_METHOD(TestEncodeThenDecodeSequence_OneEncodedByte) {
			string s("ACTG");
				Assert::AreEqual(s, encodeThenDecodeSequence(s));
		}

		TEST_METHOD(TestEncodeThenDecodeSequence_TwoEncodedBytes) {
			string s("ACTGGTTG");
			Assert::AreEqual(s, encodeThenDecodeSequence(s));
		}

		TEST_METHOD(TestEncodeThenDecodeSequence_SampleShort) {
			string s("ACGTTGCATGTCGCATGATGCATGAGAGCT");
			Assert::AreEqual(s, encodeThenDecodeSequence(s));
		}

		//TEST_METHOD(TestMostFrequentKmers_SampleShort)
		//{
		//	auto kmers = mostFrequentKmers(
		//		"ACGTTGCATGTCGCATGATGCATGAGAGCT",
		//		4);
		//	Assert::AreEqual(
		//		string("CATG GCAT"),
		//		concatenate(kmers));
		//}

		//TEST_METHOD(TestMostFrequentKmers_SampleLong)
		//{
		//	auto kmers = mostFrequentKmers(
		//		"CGGAAGCGAGATTCGCGTGGCGTGATTCCGGCGGGCGTGGAGAAGCGAGATTCATTCAAGCCGGGAGGCGTGGCGTGGCGTGGCGTGCGGATTCAAGCCGG"
		//		"CGGGCGTGATTCGAGCGGCGGATTCGAGATTCCGGGCGTGCGGGCGTGAAGCGCGTGGAGGAGGCGTGGCGTGCGGGAGGAGAAGCGAGAAGCCGGATTCA"
		//		"AGCAAGCATTCCGGCGGGAGATTCGCGTGGAGGCGTGGAGGCGTGGAGGCGTGCGGCGGGAGATTCAAGCCGGATTCGCGTGGAGAAGCGAGAAGCGCGTG"
		//		"CGGAAGCGAGGAGGAGAAGCATTCGCGTGATTCCGGGAGATTCAAGCATTCGCGTGCGGCGGGAGATTCAAGCGAGGAGGCGTGAAGCAAGCAAGCAAGCG"
		//		"CGTGGCGTGCGGCGGGAGAAGCAAGCGCGTGATTCGAGCGGGCGTGCGGAAGCGAGCGG", 12);
		//	Assert::AreEqual(
		//		string("CGGCGGGAGATT CGGGAGATTCAA CGTGCGGCGGGA CGTGGAGGCGTG CGTGGCGTGCGG GCGTGCGGCGGG GCGTGGAGGCGT GCGTGGCGTGCG "
		//		"GGAGAAGCGAGA GGAGATTCAAGC GGCGGGAGATTC GGGAGATTCAAG GTGCGGCGGGAG TGCGGCGGGAGA"),
		//		concatenate(kmers));
		//	printResults(concatenate(kmers));
		//}

		//TEST_METHOD(TestMostFrequentKmers_Quiz)
		//{
		//	auto kmers = mostFrequentKmers(
		//		"GCTCCGTGCTCCGTAACATGTTCTAGAAAACATGGCTCCGTTTCTAGAATTCTAGAAAACATGGCTCCGTGCTCCGTTAATTCAACATGTTCTAGAACATTTGATTCTAGA"
		//		"ATTCTAGAAGCTCCGTGCTCCGTTAATTCTAATTCTTCTAGAATTCTAGAATAATTCAACATGTAATTCAACATGCATTTGAGCTCCGTAACATGCATTTGACATTTGACA"
		//		"TTTGAGCTCCGTCATTTGATAATTCTTCTAGAAGCTCCGTGCTCCGTTTCTAGAACATTTGATAATTCCATTTGATAATTCAACATGCATTTGAAACATGTTCTAGAACAT"
		//		"TTGATAATTCTTCTAGAATTCTAGAAGCTCCGTAACATGTTCTAGAATTCTAGAATAATTCCATTTGACATTTGACATTTGAAACATGTTCTAGAACATTTGATTCTAGAA"
		//		"CATTTGAGCTCCGTGCTCCGTTTCTAGAATAATTCTTCTAGAAGCTCCGTTTCTAGAAGCTCCGTCATTTGACATTTGAAACATGAACATGAACATGAACATGTTCTAGAA"
		//		"GCTCCGTGCTCCGTTAATTCCATTTGAGCTCCGTTAATTCCATTTGAAACATGTAATTCCATTTGATAATTCGCTCCGTTTCTAGAACATTTGAAACATGTTCTAGAAAAC"
		//		"ATGTTCTAGAATTCTAGAAAACATGTAATTCGCTCCGTGCTCCGTCATTTGATAATTCAACATGGCTCCGTAACATGCATTTGAAACATGGCTCCGTTAATTCCATTTGAT"
		//		"TCTAGAAAACATGTTCTAGAATTCTAGAATAATTCTTCTAGAAAACATG",
		//		14);
		//	Assert::AreEqual(
		//		string("AACATGTTCTAGAA"),
		//		concatenate(kmers));
		//	printResults(concatenate(kmers));
		//}

		//TEST_METHOD(TestMostFrequentKmers_EColi)
		//{
		//	size_t length;
		//	auto sequence = readTextDataFile("E_coli.txt", &length);
		//	auto kmers = mostFrequentKmers(sequence, 14);
		//	writeToClipboard(concatenate(kmers));
		//	Assert::AreEqual(
		//		string("CTTATCAGGCCTAC"),
		//		concatenate(kmers));
		//}

		//TEST_METHOD(TestMostFrequentKmers_EColi_Times_10)
		//{
		//	size_t length;
		//	auto sequence = readTextDataFile("E_coli_Times_10.txt", &length);
		//	auto kmers = mostFrequentKmers(sequence, 14);
		//	Assert::AreEqual(
		//		string("CTTATCAGGCCTAC"),
		//		concatenate(kmers));
		//	printResults(concatenate(kmers));
		//}
	};
}