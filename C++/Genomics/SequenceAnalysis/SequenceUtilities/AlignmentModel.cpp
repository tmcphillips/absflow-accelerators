#include "AlignmentModel.h"

using std::string;
using std::vector;

AlignmentModel::AlignmentModel(vector<char> alphabet, vector<int> scores,
									 int gapOpen, int gapExtension ) :
									 size{ alphabet.size() }, scores{ scores }, 
									 gapOpenPenalty{ gapOpen }, gapExtensionPenalty{gapExtension}
{
	index.resize(256);
	for (int i = 0; i < size; i++) {
		index[alphabet[i]] = i;
	}
}

AlignmentModel::AlignmentModel(std::string alphabet, vector<int> scores,
									 int gapOpen, int gapExtension ) :
									 size{ alphabet.size() }, scores{ scores },
									 gapOpenPenalty{ gapOpen }, gapExtensionPenalty{ gapExtension }
{
	index.resize(256);
	for (int i = 0; i < size; i++) {
		index[alphabet[i]] = i;
	}
}

int AlignmentModel::score(char from, char to) {
	return scores[index[from] * size + index[to]];
}
