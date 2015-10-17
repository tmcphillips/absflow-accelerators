
#include <stdio.h>
#include "../NeedlemanWunsch_3_C_Lib/nw_matrix.h"
#include "../Libraries/SequenceUtilities/substitution_matrix.h"

int main(void) {

	nw_matrix_t* matrix;
	substitution_matrix_t* three_param_nuc_subs_model = create_two_param_nuc_subs_matrix();
	substitution_matrix_t* blosum50_protein_subs_model = create_blosum50_subs_matrix();

	matrix = nw_align_sequences(
		"ATTAAG",
		"AATCTAGC",
		three_param_nuc_subs_model,
		2
	);
	
	nw_print_scores(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);


	matrix = nw_align_sequences(
		"TAATGGA",
		"AACGGTA",
		three_param_nuc_subs_model,
		2
	);
	
	nw_print_scores(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);

	
	matrix = nw_align_sequences(
		"TAATGGATACCGGAA",
		"AACGGTAAAGGAAAATTAAGG",
		three_param_nuc_subs_model,
		2
	);
	
	nw_print_scores(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);
	nw_free_matrix(matrix);



	matrix = nw_align_sequences(
		"HEAGAWGHEE",
		"PAWHEAE", 
		blosum50_protein_subs_model,
		8);

	nw_print_scores(matrix);
	nw_print_vectors(matrix);
	printf("%s\n", matrix->gappedSequenceA);
	printf("%s\n", matrix->gappedSequenceB);
	printf("score = %d\n\n", matrix->score);

	sm_delete(three_param_nuc_subs_model);
	sm_delete(blosum50_protein_subs_model);

	return 0;
}