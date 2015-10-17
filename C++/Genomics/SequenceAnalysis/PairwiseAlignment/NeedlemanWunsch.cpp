#include "stdafx.h"
#include "NeedlemanWunsch.h"

#include <algorithm>

using std::vector;
using std::shared_ptr;


/* 	  			                Sequence A 
							j=0 j=1 j=2 j=3 
								 A   T   C
					i=0		 0	 0   0   0
    Sequence B		i=1  T	 0   0   0   0
					i=2  C   0   0   0   0
*/


NeedlemanWunsch::NeedlemanWunsch(
	const BiologicalSequence::ptr sa,
	const BiologicalSequence::ptr sb,
	const shared_ptr<AlignmentModel> sm
	) : seqa_ptr{ sa }, seqb_ptr{ sb },
	    seqa{ *sa }, seqb{ *sb }, model{ sm },
		matrix{ sb->length() + 1, sa->length() + 1 } {

		initializeTopRow();
		initializeLeftColumn();
}


void NeedlemanWunsch::initializeTopRow() {
	int max_gap_penalty = INT_MIN + 2 * (model->gapOpenPenalty + model->gapExtensionPenalty);
	auto cell_ptr = &matrix(0, 1);
	int best = -(model->gapOpenPenalty);
	traceback_vector traceback = { 0, -1, IN_B_GAP_EXTENSION };
	for (int j = 1; j < matrix.columns; j++, cell_ptr++) {
		*cell_ptr = { best, max_gap_penalty, max_gap_penalty, traceback };
		best -= model->gapExtensionPenalty;
	}
}

void NeedlemanWunsch::initializeLeftColumn() {
	int max_gap_penalty = INT_MIN + 2 * (model->gapOpenPenalty + model->gapExtensionPenalty);
	auto cell_ptr = &matrix(1, 0);
	int best = -(model->gapOpenPenalty);
	traceback_vector traceback = { -1, 0, IN_A_GAP_EXTENSION };
	for (int i = 1; i < matrix.rows; i++, cell_ptr += matrix.columns) {
		*cell_ptr = { best, max_gap_penalty, max_gap_penalty, traceback };
		best -= model->gapExtensionPenalty;
	}
}

void NeedlemanWunsch::scoreCell(int i, int j) {

	// get references to cells to be accessed
	auto& cell = matrix(i, j);
	auto& above = matrix(i - 1, j);
	auto& left = matrix(i, j - 1);

	// calculate score if sequences are matched at this cell
	int match = matrix(i - 1, j - 1).best + model->score(seqa[j - 1], seqb[i - 1]);

	// calculate possible scores if a gap is introduced at this cell
	int new_gap_a = above.best - model->gapOpenPenalty;
	int ext_gap_a = above.gap_a - model->gapExtensionPenalty;
	int new_gap_b = left.best - model->gapOpenPenalty;
	int ext_gap_b = left.gap_b - model->gapExtensionPenalty;

	bool extend_gt_open_a = ext_gap_a > new_gap_a;
	bool extend_gt_open_b = ext_gap_b > new_gap_b;

	// calculate score if a gap in sequence A is introduced at this cell
	cell.gap_a = extend_gt_open_a ? ext_gap_a : new_gap_a;

	// calculate score if a gap in sequence B is introduced at this cell
	cell.gap_b = extend_gt_open_b ? ext_gap_b : new_gap_b;

	// store best score from above possibilities along with corresponding traceback vector
	if (match >= cell.gap_b && match >= cell.gap_a) {
		cell.best = match;
		cell.back_vector.di = -1;
		cell.back_vector.dj = -1;
		cell.back_vector.gap_state = NOT_IN_GAP_EXTENSION;
	}
	else if (cell.gap_b >= cell.gap_a) {
		cell.best = cell.gap_b;
		cell.back_vector.di = 0;
		cell.back_vector.dj = -1;
		cell.back_vector.gap_state = extend_gt_open_b ? IN_B_GAP_EXTENSION : NOT_IN_GAP_EXTENSION;
	} else {
		cell.best = cell.gap_a;
		cell.back_vector.di = -1;
		cell.back_vector.dj = 0;
		cell.back_vector.gap_state = extend_gt_open_a ? IN_A_GAP_EXTENSION : NOT_IN_GAP_EXTENSION;
	}
}

AlignedSequencePair NeedlemanWunsch::computeTraceback() {

	// prepare to traverse score array starting from the bottom, right corner
	BiologicalSequence reverseGappedA{};
	BiologicalSequence reverseGappedB{};
	traceback_gap_state last_gap_state = traceback_gap_state::NOT_IN_GAP_EXTENSION;
	int i = matrix.rows - 1;
	int j = matrix.columns - 1;

	// traverse score array until the top row or left column is reached
	while (i > 0 && j > 0) {

		auto cell = matrix(i, j);


		// determine delta-i and delta-j values from gap state 
		// of last cell processed or back vector of current cell
		int di, dj;
		switch (last_gap_state) {

			case NOT_IN_GAP_EXTENSION:
				di = cell.back_vector.di;
				dj = cell.back_vector.dj;
				break;

			case IN_A_GAP_EXTENSION:
				di = -1;
				dj = 0;
				break;
			
			case IN_B_GAP_EXTENSION:
				di = 0;
				dj = -1;
				break;
		}

		// append the preceding elements of sequences of A and B or gaps 
		// to the corresponding reverse buffers based on the i and j deltas 
		reverseGappedA += dj ? seqa[j - 1] : '-';
		reverseGappedB += di ? seqb[i - 1] : '-';

		// remember gap state of this cell during next iteration
		last_gap_state = cell.back_vector.gap_state;

		// update i and j using the deltas
		i += di;
		j += dj;

	}

	// if traversal ended in top row then append remainder
	// of sequence A to its reverse buffer and corresponding gaps
	// to the reverse buffer for gapped sequence B
	while (j-- > 0) {
		reverseGappedA += seqa[j];
		reverseGappedB += '-';
	}

	// if traversal ended in left column then append remainder
	// of sequence B to its reverse buffer and corresponding gaps
	// to the reverse buffer for gapped sequence A
	while (i-- > 0) {
		reverseGappedA += '-';
		reverseGappedB += seqb[i];
	}

	return AlignedSequencePair{ reverseGappedA.reverse(), reverseGappedB.reverse(), model };
}

PairwiseAlignment NeedlemanWunsch::align() {
	
	for (int i = 1; i < matrix.rows; i++) {
		for (int j = 1; j < matrix.columns; j++) {
			scoreCell(i, j);
		}
	}

	auto alignment = computeTraceback();

	auto alignments = PairwiseAlignment(seqa_ptr, seqb_ptr);
	alignments.push_back(alignment);

	return alignments;
}



