#ifndef SEQUENCE_UTILITIES_H
#define SEQUENCE_UTILITIES_H

#include "substitution_matrix.h"

#ifdef __cplusplus
extern "C" {
#endif

char* get_reverse_sequence(char* forwardSequence);
char* get_ungapped_sequence(char* gappedSequence);
double get_fraction_identity(const char* gappedSequenceA, const char* gappedSequenceB);
char* sprint_alignment_with_identities(char* buffer, const char* gappedSequenceA, const char* gappedSequenceB);
char* sprint_alignment_with_similarities(char* string, const char* gappedSequenceA, const char* gappedSequenceB, substitution_matrix_t* substitution_matrix);

#ifdef __cplusplus
}
#endif

#endif
