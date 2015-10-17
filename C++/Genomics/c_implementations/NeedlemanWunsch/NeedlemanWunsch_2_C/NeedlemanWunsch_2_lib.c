
/******************** NeedlemanWunsch 2 ***************************************
* 
* Summary:		This project provides a simple C library that performs the
*				Needleman-Wunsch algorithm for finding the optimal complete 
*				alignment of two sequences.  Because it dynamically creates
*				the scoring matrix dynamically it can handle arbitrary 
*				sequence lengths. 
*
* Limitations:	(1) The scoring model comprises a single match score, a single
*					mismatch score, and a linear gap penalty only.
*
* Bugs:			(1) The retrace vector assignments favor gaps over substitutions
*					when the scores are identical.  This is fixed in 
*					NeedlemanWunsch_3 and succeeding projects.
*
******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "nw_matrix.h"
#include "../Libraries/SequenceUtilities/sequence_utilities.h"

int matchScore			=  2;
int mismatchScore		= -1;
int gapPenalty			=  2;


nw_matrix_t* nw_create_matrix(char* seqA, char* seqB) {
	
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
	matrix->cell  =  (nw_matrix_cell_t**) malloc(sizeof(nw_matrix_cell_t*) * matrix->columns);

	/* allocate memory for each column of cells in the score array */
	for (i = 0; i < matrix->columns; i++) {
		matrix->cell[i]  =  (nw_matrix_cell_t*) malloc(sizeof(nw_matrix_cell_t) * matrix->rows);
	}

	/* return the new nw_matrix_t instance */
	return matrix;
}

void nw_initialize_matrix(nw_matrix_t* matrix) {
	
	int i, j;

	/* set the score and vector elements of cells top row of array				*/
	for (i = 0; i < matrix->columns; i++) {
		matrix->cell[i][0].score  =  -i * gapPenalty;
		matrix->cell[i][0].di	  =  0;
		matrix->cell[i][0].dj	  =  0;
	}

	/* set the score and vector elements of cells in the left column of array	*/
	for (j = 0; j < matrix->rows; j++) {
		matrix->cell[0][j].score  =  -j * gapPenalty;
		matrix->cell[0][j].di	  =  0;
		matrix->cell[0][j].dj	  =  0;
	}
}


void nw_score_cell(nw_matrix_t* matrix, int i, int j) {

	/* compute the three possible scores of the current cell */
	int scoreIfGapInA = matrix->cell[ i ][j-1].score  -  gapPenalty;
	int scoreIfGapInB = matrix->cell[i-1][ j ].score  -  gapPenalty;
	int scoreIfMatch  = matrix->cell[i-1][j-1].score  +  ((matrix->sequenceA[i-1] == matrix->sequenceB[j-1]) ? matchScore : mismatchScore);

	/* assign the maximum of the three possible scores and save the traceback vector accordingly */
	if (scoreIfMatch > scoreIfGapInA && scoreIfMatch > scoreIfGapInB) {

		matrix->cell[i][j].score =  scoreIfMatch;
		matrix->cell[i][j].di	 = -1;
		matrix->cell[i][j].dj	 = -1;

	} else if (scoreIfGapInA > scoreIfGapInB) {

		matrix->cell[i][j].score =  scoreIfGapInA;
		matrix->cell[i][j].di	 =  0;
		matrix->cell[i][j].dj	 = -1;

	} else {

		matrix->cell[i][j].score =  scoreIfGapInB;
		matrix->cell[i][j].di	 = -1;
		matrix->cell[i][j].dj	 =  0;
	}
}

void nw_print_matrix(nw_matrix_t* matrix) {

	int i, j;

	// start array heading with two blank columns
	printf("        ");
	
	// complete array heading with the elements of sequence A 
	for (i = 0; i < matrix->columns - 1; i++) printf("%4c", matrix->sequenceA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in array
	for (j = 0; j < matrix->rows; j++) {
		
		// prefix array row with the next element of sequence B or a blank if this is not the first row
		printf("%4c", j > 0 ? matrix->sequenceB[j-1] : ' ');
		
		// display all elements in the current array row 
		for (i = 0; i < matrix->columns; i++) printf("%4d", matrix->cell[i][j].score);

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
	matrix->score = matrix->cell[i][j].score;

	// traverse score array until the top row or left column is reached
	while (i > 0 && j > 0) {
		
		// take the next deltas to apply to i and j from the current cell
		di = matrix->cell[i][j].di;
		dj = matrix->cell[i][j].dj;

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

	// free each column of the score array
	for (i = 0; i < matrix->columns; i++) {
		free(matrix->cell[i]);
	}

	// free the array of pointers to the array columns
	free(matrix->cell);

	// free the nw_matrix_t instance itself
	free(matrix);
}

nw_matrix_t* nw_align_sequences(char* sequenceA, char* sequenceB) {

	// declare indices for traversing score array
	int i, j;

	// create a new score nw_matrix_t instance
	nw_matrix_t* matrix = nw_create_matrix(sequenceA, sequenceB);

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

