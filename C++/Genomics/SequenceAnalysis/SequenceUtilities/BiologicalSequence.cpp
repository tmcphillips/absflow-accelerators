#include "BiologicalSequence.h"

#include <iostream>
#include <algorithm>
#include <vector>

using std::string;
using std::ostream;
using std::count_if;

int BiologicalSequence::ungappedLength() const {
	return std::count_if(cbegin(), cend(), [](char c) { return c != '-'; });
}

BiologicalSequence BiologicalSequence::reverse() {
	std::reverse(begin(), end());
	return *this;
}

BiologicalSequence BiologicalSequence::ungapped() const {
	BiologicalSequence s;
	std::remove_copy(cbegin(), cend(), back_inserter(s.storage), '-');
	return s;
}

std::ostream & operator<<(std::ostream& os, const BiologicalSequence& s) { return os << s.str().c_str(); }
