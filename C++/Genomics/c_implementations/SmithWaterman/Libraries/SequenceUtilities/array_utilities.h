#ifndef ARRAY_UTILITIES_H
#define ARRAY_UTILITIES_H

#ifdef __cplusplus
extern "C" {
#endif

	typedef struct {
		int rows;
		int columns;
		int** cell;
	} matrix_t;

	matrix_t* matrix_create(int rows, int columns);
	void matrix_initialize(matrix_t* matrix, int value);
	void matrix_delete(matrix_t* matrix);
	int matrix_locate_max_value(matrix_t* matrix, int* maxI, int* maxJ);

#ifdef __cplusplus
}
#endif


#endif
