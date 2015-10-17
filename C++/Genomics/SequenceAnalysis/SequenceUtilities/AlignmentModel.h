#pragma once

#include <vector>
#include <memory>

class AlignmentModel
{
public:
	AlignmentModel(std::vector<char> a, std::vector<int> s, int gapOpenPenalty = 0, int gapExtensionPenalty = 0);
	AlignmentModel(std::string a, std::vector<int> s, int gapOpenPenalty = 0, int gapExtensionPenalty = 0);
	~AlignmentModel() = default;
	int score(char from, char to);

	const int gapOpenPenalty;
	const int gapExtensionPenalty;

private:

	int size;
	std::vector<char> index;
	std::vector<int> scores;

};

std::shared_ptr<AlignmentModel> twoParamNucleotideModel(int match = 2, int mismatch = -1, int gapOpenPenalty = 0, int gapExtensionPenalty = 0);
std::shared_ptr<AlignmentModel> blosum50ProteinModel(int gapOpenPenalty = 0, int gapExtensionPenalty = 0);
std::shared_ptr<AlignmentModel> blosum62ProteinModel(int gapOpenPenalty = 0, int gapExtensionPenalty = 0);
std::shared_ptr<AlignmentModel> pam250ProteinModel(int gapOpenPenalty = 0, int gapExtensionPenalty = 0);