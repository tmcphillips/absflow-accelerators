
#include "AlignedSequencePair.h"

#include <string>
#include <sstream>
#include <algorithm>

using std::string;
using std::ostream;
using std::stringstream;
using std::endl;

int AlignedSequencePair::score() const {

	int s = 0;
	auto in_gap = false;

	for (auto fi = first.cbegin(), si = second.cbegin(); fi < first.cend() && si < second.cend(); fi++, si++) {

		if (model == nullptr) return identityCount();

		if (*fi == '-' || *si == '-') {
			if (in_gap) {
				s -= model->gapExtensionPenalty;
			}
			else {
				s -= model->gapOpenPenalty;
				in_gap = true;
			}
		}
		else {

			s += model->score(*fi, *si);
			in_gap = false;
		}
	}
	return s;
}

int AlignedSequencePair::identityCount() const {
	int matches = 0;
	for (auto fi = first.cbegin(), si = second.cbegin(); fi < first.cend() && si < second.cend(); fi++, si++) {
		if (*fi == *si && *fi != '-' && *si != '-') matches++;
	}
	return matches;
}

double AlignedSequencePair::fractionIdentity() const {
	int la = first.ungappedLength();
	int lb = second.ungappedLength();
	if (la == 0 || lb == 0) return 0;
	return double(identityCount()) / std::max(la, lb);
}

string AlignedSequencePair::correspondence() const {
	return model ? similarityCorrespondence() : identityCorrespondence();
}

string AlignedSequencePair::identityCorrespondence() const {
	string c;
	for (auto fi = first.cbegin(), si = second.cbegin(); fi < first.cend() && si < second.cend(); fi++, si++)
		c += ((*fi == *si && *fi != '-') ? '|' : ' ');
	return c;
}


string AlignedSequencePair::similarityCorrespondence() const {
	string c;
	for (auto fi = first.cbegin(), si = second.cbegin(); fi < first.cend() && si < second.cend(); fi++, si++) {
		if (*fi == '-' || *si == '-') {
			c += " ";
		} else if (*fi == *si) {
			c += "|";
		} else if (model->score(*fi, *si) > 0) {
			c += ":";
		} else {
			c += " ";
		}
	}

	return c;
}

ostream & operator<<(std::ostream& os, const AlignedSequencePair& sa) {
	return os << sa.first << endl << sa.correspondence() << endl << sa.second << endl;
}

