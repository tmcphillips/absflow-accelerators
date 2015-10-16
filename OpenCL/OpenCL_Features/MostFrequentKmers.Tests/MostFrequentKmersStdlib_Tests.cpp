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
using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace MostFrequentKmersTests
{
	//Frequent Words Problem : Find the most frequent kmers in a string.
	//  Input : A string Text and an integer k.
	//	Output : All most frequent kmers in Text.

	TEST_CLASS(MostFrequentKmersStdlib_Tests)
	{
		set<string> mostFrequentKmers(string text, int k) {

			// create map from kmer (string) to count of kmer (int)
			std::map<string, int> kmerCounts;

			// scan text for kmer with greatest count using a k-wide sliding window
			int maxCount = 0;
			int windowCount = text.length() - k + 1;
			for (unsigned windowStart = 0; windowStart < windowCount; windowStart++) {

				// at each position of window increment count of kmer in window
				string kmer = text.substr(windowStart, k);
				auto count = ++kmerCounts[kmer];

				// keep track of greatest count
				if (count > maxCount) maxCount = count;
			}

			// create an empty set of strings to hold most frequent kmers
			std::set<string> kmerSet;

			// iterate through kmer counts
			for (auto k : kmerCounts) {

				// add each kmer with count==max to the set
				if (k.second == maxCount)  kmerSet.insert(k.first);
			}

			// return the set
			return kmerSet;
		}

	public:

		TEST_METHOD(TestMostFrequentKmers_SampleShort)
		{
			auto kmers = mostFrequentKmers(
				"ACGTTGCATGTCGCATGATGCATGAGAGCT",
				4);
			Assert::AreEqual(
				string("CATG GCAT"),
				concatenate(kmers));
		}

		TEST_METHOD(TestMostFrequentKmers_SampleLong)
		{
			auto kmers = mostFrequentKmers(
				"CGGAAGCGAGATTCGCGTGGCGTGATTCCGGCGGGCGTGGAGAAGCGAGATTCATTCAAGCCGGGAGGCGTGGCGTGGCGTGGCGTGCGGATTCAAGCCGG"
				"CGGGCGTGATTCGAGCGGCGGATTCGAGATTCCGGGCGTGCGGGCGTGAAGCGCGTGGAGGAGGCGTGGCGTGCGGGAGGAGAAGCGAGAAGCCGGATTCA"
				"AGCAAGCATTCCGGCGGGAGATTCGCGTGGAGGCGTGGAGGCGTGGAGGCGTGCGGCGGGAGATTCAAGCCGGATTCGCGTGGAGAAGCGAGAAGCGCGTG"
				"CGGAAGCGAGGAGGAGAAGCATTCGCGTGATTCCGGGAGATTCAAGCATTCGCGTGCGGCGGGAGATTCAAGCGAGGAGGCGTGAAGCAAGCAAGCAAGCG"
				"CGTGGCGTGCGGCGGGAGAAGCAAGCGCGTGATTCGAGCGGGCGTGCGGAAGCGAGCGG", 12);
			Assert::AreEqual(
				string("CGGCGGGAGATT CGGGAGATTCAA CGTGCGGCGGGA CGTGGAGGCGTG CGTGGCGTGCGG GCGTGCGGCGGG GCGTGGAGGCGT GCGTGGCGTGCG "
				"GGAGAAGCGAGA GGAGATTCAAGC GGCGGGAGATTC GGGAGATTCAAG GTGCGGCGGGAG TGCGGCGGGAGA"),
				concatenate(kmers));
			printResults(concatenate(kmers));
		}

		TEST_METHOD(TestMostFrequentKmers_Quiz)
		{
			auto kmers = mostFrequentKmers(
				"GCTCCGTGCTCCGTAACATGTTCTAGAAAACATGGCTCCGTTTCTAGAATTCTAGAAAACATGGCTCCGTGCTCCGTTAATTCAACATGTTCTAGAACATTTGATTCTAGA"
				"ATTCTAGAAGCTCCGTGCTCCGTTAATTCTAATTCTTCTAGAATTCTAGAATAATTCAACATGTAATTCAACATGCATTTGAGCTCCGTAACATGCATTTGACATTTGACA"
				"TTTGAGCTCCGTCATTTGATAATTCTTCTAGAAGCTCCGTGCTCCGTTTCTAGAACATTTGATAATTCCATTTGATAATTCAACATGCATTTGAAACATGTTCTAGAACAT"
				"TTGATAATTCTTCTAGAATTCTAGAAGCTCCGTAACATGTTCTAGAATTCTAGAATAATTCCATTTGACATTTGACATTTGAAACATGTTCTAGAACATTTGATTCTAGAA"
				"CATTTGAGCTCCGTGCTCCGTTTCTAGAATAATTCTTCTAGAAGCTCCGTTTCTAGAAGCTCCGTCATTTGACATTTGAAACATGAACATGAACATGAACATGTTCTAGAA"
				"GCTCCGTGCTCCGTTAATTCCATTTGAGCTCCGTTAATTCCATTTGAAACATGTAATTCCATTTGATAATTCGCTCCGTTTCTAGAACATTTGAAACATGTTCTAGAAAAC"
				"ATGTTCTAGAATTCTAGAAAACATGTAATTCGCTCCGTGCTCCGTCATTTGATAATTCAACATGGCTCCGTAACATGCATTTGAAACATGGCTCCGTTAATTCCATTTGAT"
				"TCTAGAAAACATGTTCTAGAATTCTAGAATAATTCTTCTAGAAAACATG",
				14);
			Assert::AreEqual(
				string("AACATGTTCTAGAA"),
				concatenate(kmers));
			printResults(concatenate(kmers));
		}

		TEST_METHOD(TestMostFrequentKmers_EColi)
		{
			size_t length;
			auto sequence = readTextDataFile("E_coli.txt", &length);
			auto kmers = mostFrequentKmers(sequence, 14);
			writeToClipboard(concatenate(kmers));
			Assert::AreEqual(
				string("CTTATCAGGCCTAC"),
				concatenate(kmers));
		}

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