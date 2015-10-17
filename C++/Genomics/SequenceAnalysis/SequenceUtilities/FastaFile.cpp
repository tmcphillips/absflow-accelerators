#include "FastaFile.h"
#include <iostream>
#include <fstream>

using std::ifstream;
using std::string;
using std::make_shared;

FastaFile::FastaFile(std::string path) : path{ path }
{
	ifstream fasta_file(path);
	string line;

	seq = make_shared<BiologicalSequence>();

	if (fasta_file.is_open()) {

		/* read the header line */
		getline(fasta_file, hdr);

		/* read each line of the sequence */
		while (getline(fasta_file, line))
		{
			(*seq) += line;
		}

		fasta_file.close();
	}
}


FastaFile::~FastaFile()
{
}
