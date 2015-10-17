#include "array_utilities.h"
#include <limits.h>
#include <stdlib.h>

matrix_t* matrix_create(int rows, int columns) {

	int i;
	matrix_t* matrix = (matrix_t*) malloc(sizeof(matrix_t));
	
	matrix->rows	= rows;
	matrix->columns = columns;

	matrix->cell = (int**) malloc(sizeof(int*) * columns);
	for (i = 0; i < columns; i++) {
		matrix->cell[i] = (int*) malloc(sizeof(int) * rows);
	}

	return matrix;
}


void matrix_initialize(matrix_t* matrix, int value) {

	int i, j;

	for (i = 0; i < matrix->columns; i++) {
		for (j = 0; j < matrix->rows; j++) {
			matrix->cell[i][j] = value;
		}
	}
}

void matrix_delete(matrix_t* matrix) {

	int i;

	for (i = 0; i < matrix->columns; i++) {
		free(matrix->cell[i]);
	}

	free(matrix->cell);
	free(matrix);
}

int matrix_locate_max_value(matrix_t* matrix, int* maxI, int* maxJ) {

	int i, j;
	int max = INT_MIN;
	int value;

	for (j = 0; j < matrix->rows; j++) {
		for (i = 0; i < matrix->columns; i++) {
			value = matrix->cell[i][j];
			if (value >= max) {
				max = value;
				*maxI = i;
				*maxJ = j;
			}
		}
	}

	return max;
}