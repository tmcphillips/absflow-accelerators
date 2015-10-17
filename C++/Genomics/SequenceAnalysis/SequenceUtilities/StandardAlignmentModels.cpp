#include "AlignmentModel.h"


using std::string;
using std::vector;
using std::make_shared;

std::shared_ptr<AlignmentModel> twoParamNucleotideModel(int match, int mismatch, int gapOpenPenalty, int gapExtensionPenalty) {

	vector<char> alphabet{ 'A', 'T', 'C', 'G' };

	vector<int> scores = {
		match, mismatch, mismatch, mismatch,
		mismatch, match, mismatch, mismatch,
		mismatch, mismatch, match, mismatch,
		mismatch, mismatch, mismatch, match
	};

	return make_shared<AlignmentModel>(alphabet, scores, gapOpenPenalty, gapExtensionPenalty);
}

std::shared_ptr<AlignmentModel> blosum50ProteinModel(int gapOpenPenalty, int gapExtensionPenalty) {

	string alphabet = "ARNDCQEGHILKMFPSTWYV";

	vector<int> scores = {
		/*       A   R   N   D   C   Q   E   G   H   I   L   K   M   F   P   S   T   W   Y   V	*/
		/* A */ +5, -2, -1, -2, -1, -1, -1,  0, -2, -1, -2, -1, -1, -3, -1, +1,  0, -3, -2,  0,
		/* R */ -2, +7, -1, -2, -4, +1,  0, -3,  0, -4, -3, +3, -2, -3, -3, -1, -1, -3, -1, -3,
		/* N */ -1, -1, +7, +2, -2,  0,  0,  0, +1, -3, -4,  0, -2, -4, -2, +1,  0, -4, -2, -3,
		/* D */ -2, -2, +2, +8, -4,  0, +2, -1, -1, -4, -4, -1, -4, -5, -1,  0, -1, -5, -3, -4,
		/* C */ -1, -4, -2, -4,+13, -3, -3, -3, -3, -2, -2, -3, -2, -2, -4, -1, -1, -5, -3, -1,
		/* Q */ -1, +1,  0,  0, -3, +7, +2, -2, +1, -3, -2, +2,  0, -4, -1,  0, -1, -1, -1, -3,
		/* E */ -1,  0,  0, +2, -3, +2, +6, -3,  0, -4, -3, +1, -2, -3, -1, -1, -1, -3, -2, -3,
		/* G */  0, -3,  0, -1, -3, -2, -3, +8, -2, -4, -4, -2, -3, -4, -2,  0, -2, -3, -3, -4,
		/* H */ -2,  0, +1, -1, -3, +1,  0, -2,+10, -4, -3,  0, -1, -1, -2, -1, -2, -3, +2, -4,
		/* I */ -1, -4, -3, -4, -2, -3, -4, -4, -4, +5, +2, -3, +2,  0, -3, -3, -1, -3, -1, +4,
		/* L */ -2, -3, -4, -4, -2, -2, -3, -4, -3, +2, +5, -3, +3, +1, -4, -3, -1, -2, -1, +1,
		/* K */ -1, +3,  0, -1, -3, +2, +1, -2,  0, -3, -3, +6, -2, -4, -1,  0, -1, -3, -2, -3,
		/* M */ -1, -2, -2, -4, -2,  0, -2, -3, -1, +2, +3, -2, +7,  0, -3, -2, -1, -1,  0, +1,
		/* F */ -3, -3, -4, -5, -2, -4, -3, -4, -1,  0, +1, -4,  0, +8, -4, -3, -2, +1, +4, -1,
		/* P */ -1, -3, -2, -1, -4, -1, -1, -2, -2, -3, -4, -1, -3, -4,+10, -1, -1, -4, -3, -3,
		/* S */ +1, -1, +1,  0, -1,  0, -1,  0, -1, -3, -3,  0, -2, -3, -1, +5, +2, -4, -2, -2,
		/* T */  0, -1,  0, -1, -1, -1, -1, -2, -2, -1, -1, -1, -1, -2, -1, +2, +5, -3, -2,  0,
		/* W */ -3, -3, -4, -5, -5, -1, -3, -3, -3, -3, -2, -3, -1, +1, -4, -4, -3,+15, +2, -3,
		/* Y */ -2, -1, -2, -3, -3, -1, -2, -3, +2, -1, -1, -2, 0,  +4, -3, -2, -2, +2, +8, -1,
		/* V */  0, -3, -3, -4, -1, -3, -3, -4, -4, +4, +1, -3, +1, -1, -3, -2,  0, -3, -1, +5
	};

	return make_shared<AlignmentModel>(alphabet, scores, gapOpenPenalty, gapExtensionPenalty);
}

#include <sstream>
#include <functional>
#include <algorithm>
#include <cctype>
#include <locale>

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

vector<int> parseInts(string s, char delimiter) {
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

vector<int> parseMatrix(vector<string> lines, char delimiter=' ') {
	vector<int> m;
	for (auto line : lines) {
		auto v = parseInts(trim(line), delimiter);
		m.insert(end(m), begin(v), end(v));
	}
	return m;
}

std::shared_ptr<AlignmentModel> blosum62ProteinModel(int gapOpenPenalty, int gapExtensionPenalty) {

	string alphabet = "ACDEFGHIKLMNPQRSTVWY";

	vector<int> scores = parseMatrix(splitAndTrimLines(R"(
		 4  0 -2 -1 -2  0 -2 -1 -1 -1 -1 -2 -1 -1 -1  1  0  0 -3 -2
		 0  9 -3 -4 -2 -3 -3 -1 -3 -1 -1 -3 -3 -3 -3 -1 -1 -1 -2 -2
		-2 -3  6  2 -3 -1 -1 -3 -1 -4 -3  1 -1  0 -2  0 -1 -3 -4 -3
		-1 -4  2  5 -3 -2  0 -3  1 -3 -2  0 -1  2  0  0 -1 -2 -3 -2
		-2 -2 -3 -3  6 -3 -1  0 -3  0  0 -3 -4 -3 -3 -2 -2 -1  1  3
		 0 -3 -1 -2 -3  6 -2 -4 -2 -4 -3  0 -2 -2 -2  0 -2 -3 -2 -3
		-2 -3 -1  0 -1 -2  8 -3 -1 -3 -2  1 -2  0  0 -1 -2 -3 -2  2
		-1 -1 -3 -3  0 -4 -3  4 -3  2  1 -3 -3 -3 -3 -2 -1  3 -3 -1
		-1 -3 -1  1 -3 -2 -1 -3  5 -2 -1  0 -1  1  2  0 -1 -2 -3 -2
		-1 -1 -4 -3  0 -4 -3  2 -2  4  2 -3 -3 -2 -2 -2 -1  1 -2 -1
		-1 -1 -3 -2  0 -3 -2  1 -1  2  5 -2 -2  0 -1 -1 -1  1 -1 -1
		-2 -3  1  0 -3  0  1 -3  0 -3 -2  6 -2  0  0  1  0 -3 -4 -2
		-1 -3 -1 -1 -4 -2 -2 -3 -1 -3 -2 -2  7 -1 -2 -1 -1 -2 -4 -3
		-1 -3  0  2 -3 -2  0 -3  1 -2  0  0 -1  5  1  0 -1 -2 -2 -1
		-1 -3 -2  0 -3 -2  0 -3  2 -2 -1  0 -2  1  5 -1 -1 -3 -3 -2
		 1 -1  0  0 -2  0 -1 -2  0 -2 -1  1 -1  0 -1  4  1 -2 -3 -2
		 0 -1 -1 -1 -2 -2 -2 -1 -1 -1 -1  0 -1 -1 -1  1  5  0 -2 -2
		 0 -1 -3 -2 -1 -3 -3  3 -2  1  1 -3 -2 -2 -3 -2  0  4 -3 -1
		-3 -2 -4 -3  1 -2 -2 -3 -3 -2 -1 -4 -4 -2 -3 -3 -2 -3 11  2
		-2 -2 -3 -2  3 -3  2 -1 -2 -1 -1 -2 -3 -1 -2 -2 -2 -1  2  7
	)"));

	return make_shared<AlignmentModel>(alphabet, scores, gapOpenPenalty, gapExtensionPenalty);
}


std::shared_ptr<AlignmentModel> pam250ProteinModel(int gapOpenPenalty, int gapExtensionPenalty) {

	string alphabet = "ACDEFGHIKLMNPQRSTVWY";

	/*       A  C  D  E  F  G  H  I  K  L  M  N  P  Q  R  S  T  V  W  Y		*/
	vector<int> scores = parseMatrix(splitAndTrimLines(R"(
			 2 -2  0  0 -3  1 -1 -1 -1 -2 -1  0  1  0 -2  1  1  0 -6 -3
			-2 12 -5 -5 -4 -3 -3 -2 -5 -6 -5 -4 -3 -5 -4  0 -2 -2 -8  0
			 0 -5  4  3 -6  1  1 -2  0 -4 -3  2 -1  2 -1  0  0 -2 -7 -4
			 0 -5  3  4 -5  0  1 -2  0 -3 -2  1 -1  2 -1  0  0 -2 -7 -4
			-3 -4 -6 -5  9 -5 -2  1 -5  2  0 -3 -5 -5 -4 -3 -3 -1  0  7
			 1 -3  1  0 -5  5 -2 -3 -2 -4 -3  0  0 -1 -3  1  0 -1 -7 -5
			-1 -3  1  1 -2 -2  6 -2  0 -2 -2  2  0  3  2 -1 -1 -2 -3  0
			-1 -2 -2 -2  1 -3 -2  5 -2  2  2 -2 -2 -2 -2 -1  0  4 -5 -1
			-1 -5  0  0 -5 -2  0 -2  5 -3  0  1 -1  1  3  0  0 -2 -3 -4
			-2 -6 -4 -3  2 -4 -2  2 -3  6  4 -3 -3 -2 -3 -3 -2  2 -2 -1
			-1 -5 -3 -2  0 -3 -2  2  0  4  6 -2 -2 -1  0 -2 -1  2 -4 -2
			 0 -4  2  1 -3  0  2 -2  1 -3 -2  2  0  1  0  1  0 -2 -4 -2
			 1 -3 -1 -1 -5  0  0 -2 -1 -3 -2  0  6  0  0  1  0 -1 -6 -5
			 0 -5  2  2 -5 -1  3 -2  1 -2 -1  1  0  4  1 -1 -1 -2 -5 -4
			-2 -4 -1 -1 -4 -3  2 -2  3 -3  0  0  0  1  6  0 -1 -2  2 -4
			 1  0  0  0 -3  1 -1 -1  0 -3 -2  1  1 -1  0  2  1 -1 -2 -3
			 1 -2  0  0 -3  0 -1  0  0 -2 -1  0  0 -1 -1  1  3  0 -5 -3
			 0 -2 -2 -2 -1 -1 -2  4 -2  2  2 -2 -1 -2 -2 -1  0  4 -6 -2
			-6 -8 -7 -7  0 -7 -3 -5 -3 -2 -4 -4 -6 -5  2 -2 -5 -6 17  0
			-3  0 -4 -4  7 -5  0 -1 -4 -1 -2 -2 -5 -4 -4 -3 -3 -2  0 10
		)"));

	return make_shared<AlignmentModel>(alphabet, scores, gapOpenPenalty, gapExtensionPenalty);
}