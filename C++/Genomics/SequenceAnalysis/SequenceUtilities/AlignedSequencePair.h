#pragma once
#include <utility>
#include <string>
#include <iostream>
#include <memory>

#include "BiologicalSequence.h"
#include "AlignmentModel.h"


class AlignedSequencePair : public std::pair<BiologicalSequence, BiologicalSequence>
{
public:
	AlignedSequencePair(BiologicalSequence sa, BiologicalSequence sb) : pair{ sa, sb } {}
	AlignedSequencePair(BiologicalSequence sa, BiologicalSequence sb, std::shared_ptr<AlignmentModel> m) : pair{ sa, sb }, model{ m } {}
	~AlignedSequencePair() = default;

	int score() const;
	int identityCount() const;
	double fractionIdentity() const;
	std::string correspondence() const;

private:
	std::shared_ptr<AlignmentModel> model{ nullptr };

	std::string identityCorrespondence() const;
	std::string similarityCorrespondence() const;
};

std::ostream & operator<<(std::ostream& os, const AlignedSequencePair& sa);


