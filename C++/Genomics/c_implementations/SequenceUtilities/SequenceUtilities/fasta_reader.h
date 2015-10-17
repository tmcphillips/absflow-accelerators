#ifndef FASTA_READER_H
#define FASTA_READER_H

#ifdef __cplusplus
extern "C" {
#endif

char* read_single_sequence_fasta_file(char * header, char * sequence, const char* path);

#ifdef __cplusplus
}
#endif

#endif

