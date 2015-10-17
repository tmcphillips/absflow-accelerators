
#include <stdlib.h>
#include <string.h>

#include "substitution_matrix.h"

substitution_matrix_t* sm_create(char *alphabet, int** array) {

	int i;
	
	/* allocate memory for the new substitution_matrix_t instance */
	substitution_matrix_t* sm = (substitution_matrix_t*) malloc(sizeof(substitution_matrix_t));

	/* store the number of letters in the alphabet */
	sm->alphabet_size = strlen(alphabet);

	/* make a copy in dynamic memory of the alphabet in the substitution_matrix_t structure */
	sm->alphabet = (char*)malloc(sizeof(char) * sm->alphabet_size + 1);
	memcpy(sm->alphabet, alphabet, sm->alphabet_size + 1);

	/* copy the substitution value array to dynamic memory in the substitution_matrix_t structure */
	sm->array = (int**)malloc(sizeof(int*) * sm->alphabet_size);
	for (i = 0; i < sm->alphabet_size; i++) {
		sm->array[i] = (int*)malloc(sizeof(int) * sm->alphabet_size);
		memcpy(sm->array[i], array[i], sizeof(int) * sm->alphabet_size);
	}

	/* create the index of letters in the alphabet for rapidly looking up
	   the row or column associated with each letter						*/
	for (i = 0; i < sm->alphabet_size; i++) {
		sm->index[alphabet[i]] = i;
	}

	/* return the new substitution_matrix_t instance */
	return sm;
}

void sm_delete(substitution_matrix_t* sm) {

	int i;

	/* free memory for alphabet */
	free(sm->alphabet);

	/* free each column of the substitution score array */
	for (i = 0; i < sm->alphabet_size; i++) {
		free(sm->array[i]);
	}

	/* free the array of pointers to the columns */
	free(sm->array);
}


int sm_get_substitution_score(substitution_matrix_t* matrix, char a, char b) {

	/* look up the two letters in the alphabet index */
	char ai = matrix->index[a];
	char bi = matrix->index[b];

	/* return the substition score corresponding to the two letters */
	return matrix->array[ai][bi];
}

