#pragma once
#include "AlignedSequencePair.h"
#include <vector>
#include <memory>

class PairwiseAlignment : public std::vector<AlignedSequencePair>
{
public:
	PairwiseAlignment(BiologicalSequence::ptr a, BiologicalSequence::ptr b) : seqA{ a }, seqB{ b } {}
	const BiologicalSequence::ptr seqA;
	const BiologicalSequence::ptr seqB;
};

