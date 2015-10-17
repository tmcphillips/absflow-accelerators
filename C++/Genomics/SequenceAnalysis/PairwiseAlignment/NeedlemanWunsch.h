#pragma once

#include "BiologicalSequence.h"
#include "AlignedSequencePair.h"
#include "AlignmentModel.h"
#include "PairwiseAlignment.h"
#include "DataMatrix.h"

#include <memory>
#include <vector>

class NeedlemanWunsch
{
public: 

	enum traceback_gap_state {
		NOT_IN_GAP_EXTENSION,
		IN_A_GAP_EXTENSION,
		IN_B_GAP_EXTENSION
	};

	struct traceback_vector {
		int di;
		int dj;
		traceback_gap_state gap_state;
	};

	struct nwCell {
		int best;
		int gap_a;
		int gap_b;
		traceback_vector back_vector;
	};

	// public const data
	const BiologicalSequence& seqa;
	const BiologicalSequence& seqb;
	const std::shared_ptr<AlignmentModel> model;

	// constructors
	NeedlemanWunsch(
		const BiologicalSequence::ptr sa,
		const BiologicalSequence::ptr sb,
		const std::shared_ptr<AlignmentModel> sm
	);

	NeedlemanWunsch(BiologicalSequence sa, BiologicalSequence sb, const std::shared_ptr<AlignmentModel> sm) :
		NeedlemanWunsch(std::make_shared<BiologicalSequence>(sa),
		std::make_shared<BiologicalSequence>(sb), sm) {}

	NeedlemanWunsch(std::string sa, std::string sb,	const std::shared_ptr<AlignmentModel> sm) : 
			NeedlemanWunsch(std::make_shared<BiologicalSequence>(sa), 
							std::make_shared<BiologicalSequence>(sb), sm) {}

	// public non-const methods
	PairwiseAlignment align();

	// public const methods
	int score() { return matrix(matrix.rows - 1, matrix.columns - 1).best; }
	int f(int i, int j) { return matrix(i, j).best; }
	nwCell cell(int i, int j) { return matrix(i, j); }

private:

	// private data
	const BiologicalSequence::ptr seqa_ptr;
	const BiologicalSequence::ptr seqb_ptr;
	DataMatrix<nwCell> matrix;

	// private methods
	void initializeLeftColumn();
	void initializeTopRow();
	void scoreCell(int i, int j);
	AlignedSequencePair computeTraceback();
};


