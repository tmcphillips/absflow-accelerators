
#include <stdio.h>
#include "../NeedlemanWunsch_2_C/nw_matrix.h"


int main(void) {

	nw_matrix_t* matrix;
		
	matrix = nw_align_sequences(
		"ATTAAG",
		"AATCTAGC"
	);
	
	nw_print_matrix(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);


	matrix = nw_align_sequences(
		"TAATGGA",
		"AACGGTA"
	);
	
	nw_print_matrix(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);

	
	matrix = nw_align_sequences(
		"TAATGGATACCGGAA",
		"AACGGTAAAGGAAAATTAAGG"
	);
	
	nw_print_matrix(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);

	return 0;
}