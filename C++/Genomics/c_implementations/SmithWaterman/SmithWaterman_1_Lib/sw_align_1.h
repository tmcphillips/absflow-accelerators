#ifndef SW_ALIGN_1_H
#define SW_ALIGN_1_H

#include "../Libraries/SequenceUtilities/array_utilities.h"
#include "../Libraries/SequenceUtilities/substitution_matrix.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
	int rows;
	int columns;
	char* sequenceA;
	char* sequenceB;
	char* gappedSequenceA;
	char* gappedSequenceB;
	matrix_t* m;
	matrix_t* di;
	matrix_t* dj;
	matrix_t* ia;
	matrix_t* ib;
	substitution_matrix_t* substitution_matrix;
	int gapOpenPenalty;
	int gapExtensionPenalty;
	int score;
} sw_aligner_t;

sw_aligner_t* sw_create_aligner(char* seqA, char* seqB, substitution_matrix_t* substitution_matrix, 
	int gapOpenPenalty, int gapExtensionPenalty);
void sw_initialize_aligner(sw_aligner_t* aligner);
void sw_score_cell(sw_aligner_t* aligner, int i, int j);
void sw_print_score_matrix(sw_aligner_t* aligner);
void sw_print_vectors(sw_aligner_t* aligner);
void sw_compute_traceback(sw_aligner_t* aligner);
void sw_free_aligner(sw_aligner_t* aligner);
sw_aligner_t* sw_align_sequences(char* sequenceA, char* sequenceB, substitution_matrix_t* substitution_matrix, 
	int gapOpenPenalty, int gapExtensionPenalty);

#ifdef __cplusplus
}
#endif

#endif

