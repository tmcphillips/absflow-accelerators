// Utilities.cpp : Defines the exported functions for the DLL application.
//
#include "stdafx.h"
#include "Utilities.h"
#include <cstdlib>

using std::set;
using std::multiset;
using std::string;
using std::vector;

void printResults(string results) {
	string s = "\n***********************\n";
	s += results;
	s += "\n***********************\n";
	OutputDebugString(s.c_str());
}

void writeDebug(string message) {
	string s = "\n***********************\n";
	s += message;
	s += "\n***********************\n";
	OutputDebugString(s.c_str());
}

std::string concatenate(set<string> ss, string separator) {
	string result;
	for (auto s : ss) {
		if (result.size()) result += separator;
		result += s;
	}
	return result;
}

std::string concatenate(multiset<string> ss, char separator) {
	string result;
	for (auto s : ss) {
		if (result.size()) result += separator;
		result += s;
	}
	return result;
}

std::string concatenate(multiset<string> ss, string separator) {
	string result;
	for (auto s : ss) {
		if (result.size()) result += separator;
		result += s;
	}
	return result;
}

std::string concatenate(multiset<int> ms) {
	string result;
	for (auto i : ms) {
		if (result.size()) result += " ";
		result += std::to_string(i);
	}
	return result;
}

//string concatenate(vector<string> vs, char separator) {
//	string result;
//	for (auto s: vs) {
//		if (result.size()) result += separator;
//		result += s;
//	}
//	return result;
//}

string concatenate(vector<string> vs, string separator) {
	string result;
	for (auto s : vs) {
		if (result.size()) result += separator;
		result += s;
	}
	return result;
}

string concatenate(vector<int> vi, string separator) {
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


vector<string> concatenate(vector<vector<int>> vectors, string spacing) {
	vector<string> vs;
	for (auto pv : vectors) vs.push_back(concatenate(pv, spacing));
	std::sort(begin(vs), end(vs));
	return vs;
}


vector<int> subvector(vector<int> v, int start) {
	vector<int> s;
	for (auto i = begin(v) + start; i != end(v); i++) {
		s.push_back(*i);
	}
	return s;
}

vector<int> subvector(vector<int> v, int start, int length) {
	vector<int> s;
	for (auto i = begin(v) + start; i != begin(v) + start + length; i++) {
		s.push_back(*i);
	}
	return s;
}

vector<string> split(string s, char delimiter) {
	vector<string> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string line;
		getline(ss, line, delimiter);
		v.push_back(line);
	}
	return v;
}

vector<string> splitAndTrim(string s, char delimiter) {
	vector<string> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string line;
		getline(ss, line, delimiter);
		string trimmedLine = trim(line);
		if (trimmedLine.length() > 0) v.push_back(trimmedLine);
	}
	return v;
}

vector<string> splitAndTrimLines(string s) {
	vector<string> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string line;
		getline(ss, line);
		line = trim(line);
		if (line.length() > 0) v.push_back(line);
	}
	return v;
}

vector<vector<int>> parseIntMatrix(vector<string> lines, char delimiter) {
	vector<vector<int>> m;
	for (auto line : lines) {
		auto v = parseInts(trim(line), delimiter);
		m.push_back(v);
	}
	return m;
}


vector<int> parseInts(string s, char delimiter) {
	vector<int> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string num;
		getline(ss, num, delimiter);
		int i = atoi(num.c_str());
		v.push_back(i);
	}
	return v;
}

vector<double> parseDoubles(string s, char delimiter) {
	vector<double> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string num;
		getline(ss, num, delimiter);
		double f = atof(num.c_str());
		v.push_back(f);
	}
	return v;
}

vector <vector<double>> parseDoubles(vector<string> vs) {
	vector<vector<double>> matrix;
	for (string line : vs) {
		matrix.push_back(parseDoubles(line));
	}
	return matrix;
}


set<int> parseIntsToSet(string s, char delimiter) {
	set<int> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string num;
		getline(ss, num, delimiter);
		int i = atoi(num.c_str());
		v.insert(i);
	}
	return v;
}

std::multiset<int> parseIntsToMultiset(string s, char delimiter) {
	std::multiset<int> ms;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string num;
		getline(ss, num, delimiter);
		int i = atoi(num.c_str());
		ms.insert(i);
	}
	return ms;
}
ComparisonResult compareVectors(vector<int> v1, vector<int> v2) {
	for (auto i1 = begin(v1), i2 = begin(v2); i1 != end(v1); ++i1) {
		while (*i2 != *i1) {
			if ((*i2 > *i1) || (++i2 == end(v2))) return ComparisonResult::INCONSISTENT;
		}
		++i2;
	}
	return v1.size() == v2.size() ? ComparisonResult::EXACT_MATCH : ComparisonResult::CONSISTENT;
}

bool contains(vector<string> vs, string s) {
	return std::find(begin(vs), end(vs), s) != end(vs);
}

void writeToClipboard(string text) {
	if (!OpenClipboard(NULL)) throw "Cannot open the Clipboard";
	if (!EmptyClipboard()) throw "Cannot empty the Clipboard";
	size_t textSize = text.size() + 1;
	HGLOBAL hGlob = GlobalAlloc(GMEM_FIXED, textSize);
	if (hGlob == NULL) throw "Cannot allocate memory";
	strcpy_s((char*) hGlob, textSize, text.c_str());
	if (::SetClipboardData(CF_TEXT, hGlob) == NULL) throw "Error setting clipboard data";
	GlobalFree(hGlob);
	CloseClipboard();
}

string getEnvironmentVariable(string name) {
	char* buffer = 0;
	size_t size = 0;
	errno_t err = _dupenv_s(&buffer, &size, name.c_str());
	if (err) throw new std::exception("Error accessing environment variable");
	string result{ buffer };
	free(buffer);
	return result;
}

const char * readTextDataFile(string filename, size_t * bytes) {
	string dir = getEnvironmentVariable("BIODATA");
	string filePath = dir + filename;
	return readTextFile(filePath, bytes);
}

const char * readTextFile(string filename, size_t * bytes) {

	FILE *file;
	char *buffer;
	size_t localbytes;

	if (bytes == nullptr) bytes = &localbytes;

	//Open file
	errno_t err = fopen_s(&file, filename.c_str(), "r");
	//fopen_s(&file, filename.c_str(), "rb");
	//if (!file)
	//{
	//	fprintf(stderr, "Unable to open file %s", name);
	//	return;
	//}

	//Get file length
	fseek(file, 0, SEEK_END);
	*bytes = ftell(file);
	fseek(file, 0, SEEK_SET);

	//Allocate memory
	buffer = (char *) malloc(*bytes + 1);

	//Read file contents into buffer
	fread(buffer, *bytes, 1, file);
	buffer[*bytes] = '\0';
	fclose(file);

	return buffer;
}


const unsigned char * readBinaryFile(string filename, size_t *bytes) {

	FILE *file;
	unsigned char *buffer;
	size_t localbytes;

	if (bytes == nullptr) bytes = &localbytes;

	//Open file
	errno_t err = fopen_s(&file, filename.c_str(), "rb");
	//fopen_s(&file, filename.c_str(), "rb");
	//if (!file)
	//{
	//	fprintf(stderr, "Unable to open file %s", name);
	//	return;
	//}

	//Get file length
	fseek(file, 0, SEEK_END);
	*bytes = ftell(file);
	fseek(file, 0, SEEK_SET);

	//Allocate memory
	buffer = (unsigned char *) malloc(*bytes + 1);

	//Read file contents into buffer
	fread(buffer, *bytes, 1, file);
	fclose(file);

	return buffer;
}

vector<int> parseTrimmedInts(string s, char delimiter) {
	vector<int> v;
	std::istringstream ss{ s };
	while (!ss.eof()) {
		string num;
		getline(ss, num, delimiter);
		string trimmedNum = trim(num);
		if (trimmedNum.length() > 0) {
			int i = atoi(num.c_str());
			v.push_back(i);
		}
	}
	return v;
}

vector<int> parseTrimmedMatrix(vector<string> lines, char delimiter) {
	vector<int> m;
	for (auto line : lines) {
		auto v = parseTrimmedInts(trim(line), delimiter);
		m.insert(end(m), begin(v), end(v));
	}
	return m;
}

//// This is an example of an exported variable
//UTILITIES_API int nUtilities=0;
//
//// This is an example of an exported function.
//UTILITIES_API int fnUtilities(void)
//{
//	return 42;
//}
//
//// This is the constructor of a class that has been exported.
//// see Utilities.h for the class definition
//CUtilities::CUtilities()
//{
//	return;
//}
