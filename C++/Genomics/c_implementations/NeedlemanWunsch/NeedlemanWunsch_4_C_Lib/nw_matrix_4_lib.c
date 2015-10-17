
/******************** NeedlemanWunsch 4 ***************************************
* 
* Summary:		This project provides a simple C library that performs the
*				Needleman-Wunsch algorithm for finding the optimal complete 
*				alignment of two sequences.  Because it dynamically creates
*				the scoring matrix dynamically it can handle arbitrary 
*				sequence lengths.
*
******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "nw_matrix.h"
#include "../Libraries/SequenceUtilities/sequence_utilities.h"
#include "../Libraries/SequenceUtilities/substitution_matrix.h"

nw_matrix_t* nw_create_matrix(
	char* seqA, 
	char* seqB, 
	substitution_matrix_t* substitution_matrix, 
	int gapOpenPenalty,
	int gapExtensionPenalty) {
	
	int i;

	/* allocate a nw_matrix_t instance */
	nw_matrix_t* matrix = (nw_matrix_t*) malloc(sizeof(nw_matrix_t));
	
	/* store the dimensions of the array */
	matrix->columns	 =  strlen(seqA) + 1;		/* sequence A is printed across top of score array				*/
	matrix->rows	 =  strlen(seqB) + 1;		/* sequence B is printed down to the left of the score array	*/

	/* copy input sequences to dynamic storage associated with the nw_matrix_t instance */
	matrix->sequenceA  =  (char*) malloc(sizeof(char) * matrix->columns	);
	matrix->sequenceB  =  (char*) malloc(sizeof(char) * matrix->rows	);
	memcpy(matrix->sequenceA, seqA, matrix->columns);
	memcpy(matrix->sequenceB, seqB, matrix->rows);

	/* allocate a pointer to an array of cells for each column of the score array */ 
	matrix->m   =  (int**) malloc(sizeof(int*) * matrix->columns);
	matrix->di  =  (int**) malloc(sizeof(int*) * matrix->columns);
	matrix->dj  =  (int**) malloc(sizeof(int*) * matrix->columns);
	matrix->ia  =  (int**) malloc(sizeof(int*) * matrix->columns);
	matrix->ib  =  (int**) malloc(sizeof(int*) * matrix->columns);

	/* allocate memory for each column of cells in the score array */
	for (i = 0; i < matrix->columns; i++) {
		matrix->m[i]  =  (int*) malloc(sizeof(int) * matrix->rows);
		matrix->di[i] =  (int*) malloc(sizeof(int) * matrix->rows);
		matrix->dj[i] =  (int*) malloc(sizeof(int) * matrix->rows);
		matrix->ia[i] =  (int*) malloc(sizeof(int) * matrix->rows);
		matrix->ib[i] =  (int*) malloc(sizeof(int) * matrix->rows);
	}

	/* save the reference to the substitution matrix */
	matrix->substitution_matrix = substitution_matrix;

	/* store the gap penalties for this alignment */
	matrix->gapOpenPenalty		= gapOpenPenalty;
	matrix->gapExtensionPenalty = gapExtensionPenalty;

	/* return the new nw_matrix_t instance */
	return matrix;
}

void nw_initialize_matrix(nw_matrix_t* matrix) {
	
	int i, j;

	for (i = 1; i < matrix->columns; i++) {
		matrix->m[i][0]   =  -matrix->gapOpenPenalty - (i-1) * matrix->gapExtensionPenalty;
		matrix->ia[i][0]  =  
		matrix->ib[i][0]  =  matrix->m[i][0] - matrix->gapOpenPenalty;
		matrix->di[i][0]  = -1;
		matrix->dj[i][0]  =  0;
	}

	for (j = 1; j < matrix->rows; j++) {
		matrix->m[0][j]   =  -matrix->gapOpenPenalty - (j-1) * matrix->gapExtensionPenalty;
		matrix->ia[0][j]  =  
		matrix->ib[0][j]  =   matrix->m[0][j] - matrix->gapOpenPenalty;
		matrix->di[0][j]  =  0;
		matrix->dj[0][j]  = -1;
	}

	matrix->m[0][0]   = 0;
	matrix->di[0][0]  = 0;
	matrix->dj[0][0]  = 0;
	matrix->ia[0][0]  = 0;
	matrix->ib[0][0]  = 0;
}

int maxInt(int a, int b) {
	if (a >= b) {
		return a;
	} else {
		return b;
	}
}

void nw_score_cell(nw_matrix_t* matrix, int i, int j) {

	int sAiBj, Fij, Gij, Hij;

	matrix->ia[i][j] =	maxInt(	matrix->m [i][j-1] - matrix->gapOpenPenalty,
								matrix->ia[i][j-1] - matrix->gapExtensionPenalty );
	
	matrix->ib[i][j] =	maxInt(	matrix->m [i-1][j] - matrix->gapOpenPenalty,
								matrix->ib[i-1][j] - matrix->gapExtensionPenalty );

	sAiBj = sm_get_substitution_score(
					matrix->substitution_matrix,
					matrix->sequenceA[i-1],
					matrix->sequenceB[j-1]
	);
	
	Fij	 =  matrix->m[i-1][j-1] + sAiBj;
	Gij	 =  matrix->ia[i][j];
	Hij	 =  matrix->ib[i][j];

	if (Fij >= Gij && Fij >= Hij) {

		matrix->m [i][j]  =  Fij;
		matrix->di[i][j]  = -1;
		matrix->dj[i][j]  = -1;

	} else if (Gij > Hij) {

		matrix->m [i][j]  =   Gij;
		matrix->di[i][j]  =   0;
		matrix->dj[i][j]  =  -1;

	} else {

		matrix->m [i][j]  =   Hij;
		matrix->di[i][j]  =  -1;
		matrix->dj[i][j]  =   0;
	}
}

void nw_print_matrix(nw_matrix_t* matrix) {

	int i, j;
	char buf[20];

	// start array heading with two blank columns
	printf("        ");
	
	// complete array heading with the elements of sequence A 
	for (i = 0; i < matrix->columns - 1; i++) printf("%12c", matrix->sequenceA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in array
	for (j = 0; j < matrix->rows; j++) {
		
		// prefix array row with the next element of sequence B or a blank if this is not the first row
		printf(" %c", j > 0 ? matrix->sequenceB[j-1] : ' ');
		
		// display all elements in the current array row 
		for (i = 0; i < matrix->columns; i++) {
			sprintf(buf, "(%d,%d,%d)", matrix->m[i][j], matrix->ia[i][j], matrix->ib[i][j]);
			printf("%12s", buf);
		}

		// print a blank line
		printf("\n\n");
	}

	// print a final blank line
	printf("\n");
}

void nw_print_vectors(nw_matrix_t* matrix) {

	int i, j;
	char buf[9];

	// start array heading with two blank columns
	printf("        ");
	
	// complete array heading with the elements of sequence A 
	for (i = 0; i < matrix->columns - 1; i++) printf("%8c", matrix->sequenceA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in array
	for (j = 0; j < matrix->rows; j++) {
		
		// prefix array row with the next element of sequence B or a blank if this is not the first row
		printf(" %c", j > 0 ? matrix->sequenceB[j-1] : ' ');
		
		// display all elements in the current array row 
		for (i = 0; i < matrix->columns; i++) {
			sprintf(buf, "(%d,%d)", matrix->di[i][j], matrix->dj[i][j]);
			printf("%8s", buf);
		}

		// print a blank line
		printf("\n\n");
	}

	// print a final blank line
	printf("\n");
}



void nw_compute_traceback(nw_matrix_t* matrix) {

	// allocate memory for reverse, gapped sequences with enough room for as
	// many gaps in each as there are non-gaps is the other sequence
	int bufferLength  = matrix->rows + matrix->columns;
	char* reverseBufferA = (char*)malloc(sizeof(char) * bufferLength);
	char* reverseBufferB = (char*)malloc(sizeof(char) * bufferLength);

	// initialize indices for reverse buffers
	int k = 0;
	int l = 0;

	// declare delta i and delta j variables
	int di, dj;

	// prepare to traverse score array starting from the bottom, right corner
	int i = matrix->columns - 1;
	int j = matrix->rows	- 1;

	// take the overall alignment score from the bottom, right-hand array cell 
	matrix->score = matrix->m[i][j];

	// traverse score array until the top row or left column is reached
	while (i > 0 && j > 0) {
		
		// take the next deltas to apply to i and j from the current cell
		di = matrix->di[i][j];
		dj = matrix->dj[i][j];

		// append the preceding elements of sequences of A and B or gaps 
		// to the corresponding reverse buffers based on the i and j deltas 
		reverseBufferA[k++] = (di == 0) ? '-' : matrix->sequenceA[i-1];
		reverseBufferB[l++] = (dj == 0) ? '-' : matrix->sequenceB[j-1];

		// update i and j using the deltas
		i += di;
		j += dj;
	}

	// if traversal ended in top row then append remainder
	// of sequence A to its reverse buffer and corresponding gaps
	// to the reverse buffer for gapped sequence B
	while (i > 0) {
		reverseBufferA[k++] = matrix->sequenceA[i-1];
		reverseBufferB[l++] = '-';
		i--;
	}

	// if traversal ended in left column then append remainder
	// of sequence B to its reverse buffer and corresponding gaps
	// to the reverse buffer for gapped sequence A
	while (j > 0) {
		reverseBufferA[k++] = '-';
		reverseBufferB[l++] = matrix->sequenceB[j-1];
		j--;
	}

	// null-terminate the two reverse buffer strings
	reverseBufferA[k] = 0;
	reverseBufferB[l] = 0;

	// save the reverses of the two buffers as the two gapped sequences
	matrix->gappedSequenceA = get_reverse_sequence(reverseBufferA);
	matrix->gappedSequenceB = get_reverse_sequence(reverseBufferB);

	// free the memory for the two reverse buffers
	free(reverseBufferA);
	free(reverseBufferB);
}

void nw_free_matrix(nw_matrix_t* matrix) {
	
	int i;

	// free the ungapped sequences
	free(matrix->sequenceA);
	free(matrix->sequenceB);

	// free the gapped sequences
	free(matrix->gappedSequenceA);
	free(matrix->gappedSequenceB);

	// free each column of the score arrays
	for (i = 0; i < matrix->columns; i++) {
		free(matrix->m[i]);
		free(matrix->di[i]);
		free(matrix->dj[i]);
		free(matrix->ia[i]);
		free(matrix->ib[i]);
	}

	// free the arrays of pointers to the array columns
	free(matrix->m);
	free(matrix->di);
	free(matrix->dj);
	free(matrix->ia);
	free(matrix->ib);

	// free the nw_matrix_t instance itself
	free(matrix);
}

nw_matrix_t* nw_align_sequences(
	char* sequenceA, 
	char* sequenceB, 
	substitution_matrix_t* substitution_matrix,
	int gapOpenPenalty,
	int gapExtensionPenalty) {

	// declare indices for traversing score array
	int i, j;

	// create a new score nw_matrix_t instance
	nw_matrix_t* matrix = nw_create_matrix(sequenceA, sequenceB, substitution_matrix, gapOpenPenalty, gapExtensionPenalty);

	// fill values in top row and left column of score array
	nw_initialize_matrix(matrix);

	// fill in the remainder of the score array starting from
	// the top left and ending at the bottom right corner
	for (i = 1; i < matrix->columns; i++) {
		for (j = 1; j < matrix->rows; j++) {
			nw_score_cell(matrix, i, j);
		}
	}

	// compute the two gapped sequences from the score array
	nw_compute_traceback(matrix);

	return matrix;
}

