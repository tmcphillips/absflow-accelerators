
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "sequence_utilities.h"
#include "substitution_matrix.h"

char* get_reverse_sequence(char* forwardString) {

	int i;
	int length = strlen(forwardString);
	char *reverse = (char*) malloc((sizeof(char) * length) + 1);
	char *f = forwardString;
	char *r = reverse + length;
	*r-- = 0;
	for (i = 0; i < length; i++) 
		*r-- = *f++;

	return reverse;
}


char* get_ungapped_sequence(char* gappedSequence) {

	char* ungappedSequence = (char*) malloc(sizeof(char) * strlen(gappedSequence) + 1);
	
	char* uPtr = ungappedSequence;
	char* gPtr = gappedSequence;

	while (*gPtr != 0) {
		if (*gPtr != '-') {
			*uPtr++ = *gPtr;
		}
		gPtr++;
	}
	
	*uPtr = 0;

	return ungappedSequence;
}

double get_fraction_identity(const char* gappedSequenceA, const char* gappedSequenceB) {

	const char* a = gappedSequenceA;
	const char* b = gappedSequenceB;
	int letterCount = 0;
	int matchCount = 0;

	while (*a != 0) {
		
		if (*a != '-') {
			letterCount++; 
			if (*a == *b) {
				matchCount++;
			}
		}

		a++;
		b++;
	}

	if (letterCount == 0)
		return 0;
	else
		return ((double)matchCount) / letterCount;
}

char* sprint_alignment_with_identities(char* string, const char* gappedSequenceA, const char* gappedSequenceB) {

	const char* a;
	const char* b;

	char* s = string;

	a = gappedSequenceA;
	while(*a != 0) {
		*s++ = *a++;
	}
	*s++ = '\n';

	a = gappedSequenceA;
	b = gappedSequenceB;
	while(*b != 0 && *b != 0) {
		if (*a++ == *b++) {
			*s++ = '|';
		} else {
			*s++ = ' ';
		}
	}
	*s++ = '\n';

	b = gappedSequenceB;
	while(*b != 0) {
		*s++ = *b++;
	}
	*s++ = '\n';
	*s = 0;

	return string;
}


char* sprint_alignment_with_similarities(char* string, const char* gappedSequenceA, const char* gappedSequenceB, substitution_matrix_t* substitution_matrix) {

	int similarity;
	const char* a;
	const char* b;

	char* s = string;

	a = gappedSequenceA;
	while(*a != 0) {
		*s++ = *a++;
	}
	*s++ = '\n';

	a = gappedSequenceA;
	b = gappedSequenceB;
	while(*a != 0 && *b != 0) {
		if (*a == *b) {
			*s++ = '|';
		} else if (*a != '-' && *b != '-' && sm_get_substitution_score(substitution_matrix, *a, *b) > 0) {
			*s++ = ':';
		} else {
			*s++ = ' ';
		}
		a++;
		b++;
	}
	*s++ = '\n';

	b = gappedSequenceB;
	while(*b != 0) {
		*s++ = *b++;
	}
	*s++ = '\n';
	*s = 0;

	return string;
}
