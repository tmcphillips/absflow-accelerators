#include <stdio.h>
#include <string.h>
#include "fasta_reader.h"

char* read_single_sequence_fasta_file(char * header, char * sequence, const char* path) {

	int c;
	char* s;

	/* open the file for reading */
	FILE* file = fopen(path, "r");

	/* read the header line */
	fgets(header, 81, file);
	
	/* terminate header with null to eliminate newline character */
	header[strlen(header) - 1] = 0;

	/* point at beginning of sequence buffer */
	s = sequence;

	/* read characters from file until end of file is reached */
	while ( (c = fgetc(file)) != EOF) {

		// store the latest character in the sequence if it is not a newline
		if (c != '\n') {
			*s++ = (char)c;
		}
	}
	
	// terminate the sequence buffer with a null
	*s = 0;

	return sequence;
}
