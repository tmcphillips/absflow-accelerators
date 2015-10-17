#ifndef SUBSTITUTION_MATRIX_H
#define SUBSTITUTION_MATRIX_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
	char* alphabet;
	int alphabet_size;
	char index[256];
	int** array;
	int gapPenalty;
} substitution_matrix_t;

substitution_matrix_t* sm_create(char* alphabet, int** array);
int sm_get_substitution_score(substitution_matrix_t* matrix, char a, char b);
void sm_delete(substitution_matrix_t* matrix);

substitution_matrix_t* create_two_param_nuc_subs_matrix();
substitution_matrix_t* create_blosum50_subs_matrix();

#ifdef __cplusplus
}
#endif

#endif
