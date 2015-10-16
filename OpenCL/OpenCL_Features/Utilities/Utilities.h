#pragma once

#define UTILITIES_API 

#include <string>
#include <vector>
#include <set>
#include <map>
#include <algorithm>
#include <functional> 
#include <cctype>
#include <locale>


template<class T>
std::string concatenate(T vi, std::string separator = " ") {
	std::stringstream ss;
	bool first{ true };
	for (auto i : vi) {
		if (!first) {
			ss << separator;
		}
		else {
			first = false;
		}
		ss << i;
	}
	return ss.str();
}

UTILITIES_API void printResults(std::string results);
UTILITIES_API void writeDebug(std::string message);

UTILITIES_API std::vector<std::string> concatenate(std::vector<std::vector<int>> vectors, std::string spacing = "-");

UTILITIES_API std::string concatenate(std::vector<int> vi, std::string separator = " ");
UTILITIES_API std::string concatenate(std::set<std::string> ss, std::string separator = " ");
//UTILITIES_API std::string concatenate(std::multiset<std::string> ss, char separator = ' ');
UTILITIES_API std::string concatenate(std::multiset<std::string> ss, std::string separator = " ");
UTILITIES_API std::string concatenate(std::multiset<int> ms);
//UTILITIES_API std::string concatenate(std::vector<std::string> vs, char separator = ' ');
UTILITIES_API std::string concatenate(std::vector<std::string> vs, std::string separator = " ");

UTILITIES_API std::vector<int> subvector(std::vector<int> v, int start);
UTILITIES_API std::vector<int> subvector(std::vector<int> v, int start, int length);


UTILITIES_API std::vector<std::string> split(std::string s, char delimiter);
UTILITIES_API std::vector<std::string> splitAndTrim(std::string s, char delimiter);
UTILITIES_API std::vector<std::string> splitAndTrimLines(std::string s);

UTILITIES_API std::vector<std::vector<int>> parseIntMatrix(std::vector<std::string> lines, char delimiter = ' ');

UTILITIES_API std::vector<int> parseInts(std::string s, char delimiter = ' ');
UTILITIES_API std::set<int> parseIntsToSet(std::string s, char delimiter = ' ');
UTILITIES_API std::multiset<int> parseIntsToMultiset(std::string s, char delimiter = ' ');

UTILITIES_API std::vector<double> parseDoubles(std::string s, char delimiter = ' ');
UTILITIES_API std::vector <std::vector<double>> parseDoubles(std::vector<std::string> vs);

enum class UTILITIES_API ComparisonResult { EXACT_MATCH, CONSISTENT, INCONSISTENT };
UTILITIES_API ComparisonResult compareVectors(std::vector<int> v1, std::vector<int> v2);
UTILITIES_API bool contains(std::vector<std::string> vs, std::string s);

UTILITIES_API void writeToClipboard(std::string text);

UTILITIES_API const char * readTextFile(std::string filename, size_t * bytes = nullptr);
UTILITIES_API const char * readTextDataFile(std::string filename, size_t * bytes = nullptr);
UTILITIES_API const unsigned char * readBinaryFile(std::string filename, size_t *bytes = nullptr);

inline std::string &ltrim(std::string &s) {
	s.erase(s.begin(), std::find_if(s.begin(), s.end(), std::not1(std::ptr_fun<int, int>(std::isspace))));
	return s;
}

inline std::string &rtrim(std::string &s) {
	s.erase(std::find_if(s.rbegin(), s.rend(), std::not1(std::ptr_fun<int, int>(std::isspace))).base(), s.end());
	return s;
}

inline std::string &trim(std::string &s) {
	return ltrim(rtrim(s));
}


UTILITIES_API std::vector<int> parseTrimmedInts(std::string s, char delimiter = ' ');
UTILITIES_API std::vector<int> parseTrimmedMatrix(std::vector<std::string> lines, char delimiter = ' ');