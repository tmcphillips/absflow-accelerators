
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

#include "sw_align_1.h"
#include "../Libraries/SequenceUtilities/sequence_utilities.h"
#include "../Libraries/SequenceUtilities/substitution_matrix.h"

sw_aligner_t* sw_create_aligner(
	char* seqA, 
	char* seqB, 
	substitution_matrix_t* substitution_matrix, 
	int gapOpenPenalty,
	int gapExtensionPenalty) {

	/* allocate a nw_matrix_t instance */
	sw_aligner_t* aligner = (sw_aligner_t*) malloc(sizeof(sw_aligner_t));
	
	/* store the dimensions of the array */
	aligner->columns	=  strlen(seqA) + 1;		/* sequence A is printed across top of score array				*/
	aligner->rows		=  strlen(seqB) + 1;		/* sequence B is printed down to the left of the score array	*/

	/* copy input sequences to dynamic storage associated with the nw_matrix_t instance */
	aligner->sequenceA  =  (char*) malloc(sizeof(char) * aligner->columns	);
	aligner->sequenceB  =  (char*) malloc(sizeof(char) * aligner->rows	);
	memcpy(aligner->sequenceA, seqA, aligner->columns);
	memcpy(aligner->sequenceB, seqB, aligner->rows);

	/* allocate a pointer to an array of cells for each column of the score array */ 
	aligner->m   =  matrix_create(aligner->rows, aligner->columns);
	aligner->di  =  matrix_create(aligner->rows, aligner->columns);
	aligner->dj  =  matrix_create(aligner->rows, aligner->columns);
	aligner->ia  =  matrix_create(aligner->rows, aligner->columns);
	aligner->ib  =	matrix_create(aligner->rows, aligner->columns);

	/* save the reference to the substitution matrix */
	aligner->substitution_matrix = substitution_matrix;

	/* store the gap penalties for this alignment */
	aligner->gapOpenPenalty		= gapOpenPenalty;
	aligner->gapExtensionPenalty = gapExtensionPenalty;

	/* return the new nw_matrix_t instance */
	return aligner;
}

void sw_initialize_aligner(sw_aligner_t* aligner) {
	
	int i, j;

	for (i = 1; i < aligner->columns; i++) {
		aligner-> m->cell[i][0]  =  0;
		aligner->ia->cell[i][0]  =  
		aligner->ib->cell[i][0]  =  -aligner->gapOpenPenalty;
		aligner->di->cell[i][0]  = -1;
		aligner->dj->cell[i][0]  =  0;
	}

	for (j = 1; j < aligner->rows; j++) {
		aligner-> m->cell[0][j]  =  0;
		aligner->ia->cell[0][j]  =  
		aligner->ib->cell[0][j]  =  - aligner->gapOpenPenalty;
		aligner->di->cell[0][j]  =  0;
		aligner->dj->cell[0][j]  = -1;
	}

	aligner-> m->cell[0][0]  = 0;
	aligner->di->cell[0][0]  = 0;
	aligner->dj->cell[0][0]  = 0;
	aligner->ia->cell[0][0]  = 0;
	aligner->ib->cell[0][0]  = 0;
}

int maxInt(int a, int b) {
	if (a >= b) {
		return a;
	} else {
		return b;
	}
}

void sw_score_cell(sw_aligner_t* aligner, int i, int j) {

	int sAiBj, Fij, Gij, Hij;

	aligner->ia->cell[i][j] =	maxInt(	aligner->m ->cell[i][j-1] - aligner->gapOpenPenalty,
										aligner->ia->cell[i][j-1] - aligner->gapExtensionPenalty );
	
	aligner->ib->cell[i][j] =	maxInt(	aligner->m ->cell[i-1][j] - aligner->gapOpenPenalty,
										aligner->ib->cell[i-1][j] - aligner->gapExtensionPenalty );

	sAiBj = sm_get_substitution_score(
					aligner->substitution_matrix,
					aligner->sequenceA[i-1],
					aligner->sequenceB[j-1]
	);
	
	Fij	 =  aligner->m->cell[i-1][j-1] + sAiBj;
	Gij	 =  aligner->ia->cell[i][j];
	Hij	 =  aligner->ib->cell[i][j];

	if (Fij >= Gij && Fij >= Hij) {

		aligner->m->cell [i][j]  =  Fij;
		aligner->di->cell[i][j]  = -1;
		aligner->dj->cell[i][j]  = -1;

	} else if (Gij > Hij) {

		aligner->m->cell [i][j]  =   Gij;
		aligner->di->cell[i][j]  =   0;
		aligner->dj->cell[i][j]  =  -1;

	} else {

		aligner->m->cell [i][j]  =   Hij;
		aligner->di->cell[i][j]  =  -1;
		aligner->dj->cell[i][j]  =   0;
	}

	if (aligner->m->cell[i][j] < 0) {
		aligner->m->cell[i][j] = 0;
	}
}

void sw_print_score_matrix(sw_aligner_t* aligner) { 

	int i, j;
	char buf[20];

	// start array heading with two blank columns
	printf("        ");
	
	// complete array heading with the elements of sequence A 
	for (i = 0; i < aligner->columns - 1; i++) printf("%12c", aligner->sequenceA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in array
	for (j = 0; j < aligner->rows; j++) {
		
		// prefix array row with the next element of sequence B or a blank if this is not the first row
		printf(" %c", j > 0 ? aligner->sequenceB[j-1] : ' ');
		
		// display all elements in the current array row 
		for (i = 0; i < aligner->columns; i++) {
			sprintf(buf, "(%d,%d,%d)", aligner->m->cell[i][j], aligner->ia->cell[i][j], aligner->ib->cell[i][j]);
			printf("%12s", buf);
		}

		// print a blank line
		printf("\n\n");
	}

	// print a final blank line
	printf("\n");
}

void sw_print_vectors(sw_aligner_t* aligner) {

	int i, j;
	char buf[9];

	// start array heading with two blank columns
	printf("        ");
	
	// complete array heading with the elements of sequence A 
	for (i = 0; i < aligner->columns - 1; i++) printf("%8c", aligner->sequenceA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in array
	for (j = 0; j < aligner->rows; j++) {
		
		// prefix array row with the next element of sequence B or a blank if this is not the first row
		printf(" %c", j > 0 ? aligner->sequenceB[j-1] : ' ');
		
		// display all elements in the current array row 
		for (i = 0; i < aligner->columns; i++) {
			sprintf(buf, "(%d,%d)", aligner->di->cell[i][j], aligner->dj->cell[i][j]);
			printf("%8s", buf);
		}

		// print a blank line
		printf("\n\n");
	}

	// print a final blank line
	printf("\n");
}



void sw_compute_traceback(sw_aligner_t* aligner) {

	// allocate memory for reverse, gapped sequences with enough room for as
	// many gaps in each as there are non-gaps is the other sequence
	int bufferLength  = aligner->rows + aligner->columns;
	char* reverseBufferA = (char*)malloc(sizeof(char) * bufferLength);
	char* reverseBufferB = (char*)malloc(sizeof(char) * bufferLength);

	// initialize indices for reverse buffers
	int k = 0;
	int l = 0;

	// declare delta i and delta j variables
	
	int di, dj;

	int i, j;

	aligner->score = matrix_locate_max_value(aligner->m, &i, &j);

	// take the overall alignment score from the bottom, right-hand array cell 
	aligner->score = aligner->m->cell[i][j];

	// traverse score array until the top row or left column is reached
	while (aligner->m->cell[i][j] > 0) {

		// take the next deltas to apply to i and j from the current cell
		di = aligner->di->cell[i][j];
		dj = aligner->dj->cell[i][j];

		// append the preceding elements of sequences of A and B or gaps 
		// to the corresponding reverse buffers based on the i and j deltas 
		reverseBufferA[k++] = (di == 0) ? '-' : aligner->sequenceA[i-1];
		reverseBufferB[l++] = (dj == 0) ? '-' : aligner->sequenceB[j-1];

		// update i and j using the deltas
		i += di;
		j += dj;
	}

	// null-terminate the two reverse buffer strings
	reverseBufferA[k] = 0;
	reverseBufferB[l] = 0;

	// save the reverses of the two buffers as the two gapped sequences
	aligner->gappedSequenceA = get_reverse_sequence(reverseBufferA);
	aligner->gappedSequenceB = get_reverse_sequence(reverseBufferB);

	// free the memory for the two reverse buffers
	free(reverseBufferA);
	free(reverseBufferB);
}

void sw_free_aligner(sw_aligner_t* aligner) {

	// free the ungapped sequences
	free(aligner->sequenceA);
	free(aligner->sequenceB);

	// free the gapped sequences
	free(aligner->gappedSequenceA);
	free(aligner->gappedSequenceB);

	// free the arrays of pointers to the array columns
	matrix_delete(aligner->m);
	matrix_delete(aligner->di);
	matrix_delete(aligner->dj);
	matrix_delete(aligner->ia);
	matrix_delete(aligner->ib);

	// free the nw_matrix_t instance itself
	free(aligner);
}

sw_aligner_t* sw_align_sequences(
	char* sequenceA, 
	char* sequenceB, 
	substitution_matrix_t* substitution_matrix,
	int gapOpenPenalty,
	int gapExtensionPenalty) {

	// declare indices for traversing score array
	int i, j;

	// create a new score nw_matrix_t instance
	sw_aligner_t* aligner = sw_create_aligner(sequenceA, sequenceB, substitution_matrix, gapOpenPenalty, gapExtensionPenalty);

	// fill values in top row and left column of score array
	sw_initialize_aligner(aligner);

	// fill in the remainder of the score array starting from
	// the top left and ending at the bottom right corner
	for (i = 1; i < aligner->columns; i++) {
		for (j = 1; j < aligner->rows; j++) {
			sw_score_cell(aligner, i, j);
		}
	}

	// compute the two gapped sequences from the score array
	sw_compute_traceback(aligner);

	return aligner;
}

