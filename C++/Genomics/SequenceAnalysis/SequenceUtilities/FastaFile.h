#pragma once

#include "BiologicalSequence.h"

#include <string>
#include <memory>

class FastaFile
{

public:

	FastaFile(std::string path);
	~FastaFile();

	const std::string& getHeader() const { return hdr; }
	const std::shared_ptr<BiologicalSequence> sequence() const { return seq; }

private:

	std::string hdr;
	std::shared_ptr<BiologicalSequence> seq;
	const std::string path;

};

