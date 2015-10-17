#ifndef NW_MATRIX_H
#define NW_MATRIX_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
	int score;
	int di;
	int dj;
} nw_matrix_cell_t;

typedef struct {
	int rows;
	int columns;
	char* sequenceA;
	char* sequenceB;
	char* gappedSequenceA;
	char* gappedSequenceB;
	nw_matrix_cell_t** cell;
	int score;
} nw_matrix_t;

nw_matrix_t* nw_create_matrix(char* seqA, char* seqB);
void nw_initialize_matrix(nw_matrix_t* matrix);
void nw_score_cell(nw_matrix_t* matrix, int i, int j);
void nw_print_matrix(nw_matrix_t* matrix);
void nw_compute_traceback(nw_matrix_t* matrix);
void nw_free_matrix(nw_matrix_t* matrix);
nw_matrix_t* nw_align_sequences(char* sequenceA, char* sequenceB);

#ifdef __cplusplus
}
#endif

#endif
