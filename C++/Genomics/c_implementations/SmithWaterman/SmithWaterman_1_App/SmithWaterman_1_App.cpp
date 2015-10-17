#include <stdio.h>
#include "../SmithWaterman_1_Lib/sw_align_1.h"
#include "../Libraries/SequenceUtilities/substitution_matrix.h"
#include "../Libraries/SequenceUtilities/sequence_utilities.h"

int main(void) {

	char displayString[1000];
	sw_aligner_t* matrix;
	substitution_matrix_t* three_param_nuc_subs_model = create_two_param_nuc_subs_matrix();
	substitution_matrix_t* blosum50_protein_subs_model = create_blosum50_subs_matrix();

	matrix = sw_align_sequences(
		"ATTAAG",
		"AATCTAGC",
		three_param_nuc_subs_model,
		2,
		1  
	);
	
	sw_print_score_matrix(matrix);
	printf("%s\n", sprint_alignment_with_identities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB));
	printf("score = %d\n\n", matrix->score);
	sw_free_aligner(matrix);

	matrix = sw_align_sequences(
		"ATTAAG",
		"AATCTAGC",
		three_param_nuc_subs_model,
		2,
		1
	);

	
	sw_print_score_matrix(matrix);
	sw_print_vectors(matrix);
	printf("%s\n", sprint_alignment_with_identities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB));
	printf("score = %d\n\n", matrix->score);
	sw_free_aligner(matrix);

	matrix = sw_align_sequences(
		"TAATGGA",
		"AACGGTA",
		three_param_nuc_subs_model,
		2,
		2
	);
	
	sw_print_score_matrix(matrix);
	printf("%s\n", sprint_alignment_with_identities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB));
	printf("score = %d\n\n", matrix->score);
	sw_free_aligner(matrix);

	
	matrix = sw_align_sequences(
		"TAATGGATACCGGAA",
		"AACGGTAAAGGAAAATTAAGG",
		three_param_nuc_subs_model,
		2,
		2
	);
	
	sw_print_score_matrix(matrix);
	printf("%s\n", sprint_alignment_with_identities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB));
	printf("score = %d\n\n", matrix->score);
	sw_free_aligner(matrix);


	matrix = sw_align_sequences(
		"HEAGAWGHEE",
		"PAWHEAE", 
		blosum50_protein_subs_model,
		8,
		8);

	sw_print_score_matrix(matrix);
	printf("%s\n", sprint_alignment_with_similarities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB, blosum50_protein_subs_model));
	printf("score = %d\n\n", matrix->score);

	matrix = sw_align_sequences(
		"ALLLQPLLGAQGAPLEPVYPGDNATPEQMAQYAADLRRYINMLTRPRYGKRHKEDTLAF",
		"GPSQPTYPGDDAPVEDLIRFYDNLQQYLNVVTRHRY", 
		blosum50_protein_subs_model,
		10,
		1);
	printf("%s\n", sprint_alignment_with_similarities(displayString, matrix->gappedSequenceA, matrix->gappedSequenceB, blosum50_protein_subs_model));
	printf("score = %d\n\n", matrix->score);


	sm_delete(three_param_nuc_subs_model);
	sm_delete(blosum50_protein_subs_model);

	return 0;
}