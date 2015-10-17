#include "stdafx.h"
#include "CppUnitTest.h"
#include <string.h>

#include "TestUtilities.h"
#include "nw_matrix.h"
#include "sequence_utilities.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

void TestUtilities::Utilities::AssertIsSane(nw_matrix_t* matrix) {

	// make sure two gapped sequences have the same length
	Assert::AreEqual(
		strlen(matrix->gappedSequenceA), 
		strlen(matrix->gappedSequenceB)
	);

	// make sure the alignment score is the same as the score in the bottom, right-hand cell
	Assert::AreEqual(
		matrix->m[matrix->columns-1][matrix->rows-1], 
		matrix->score
	);

	// make the sure the gapped sequences are the same as the original sequences when gaps are removed
	Utilities::AreEqual(
		matrix->sequenceA, 
		get_ungapped_sequence(matrix->gappedSequenceA)
	);

	Utilities::AreEqual(
		matrix->sequenceB, 
		get_ungapped_sequence(matrix->gappedSequenceB)
	);
}

void TestUtilities::Utilities::AreEqual(int* expected, int** actual, int columns, int rows) {

//	char buffer[128];

	for (int i = 0; i < columns; i++) {
		for (int j = 0; j < rows; j++) {
			Assert::AreEqual<int>(
				expected[j * columns + i], 
				actual[i][j], 
				(wchar_t*)"Mismatch at element."
			);
		}
	}
}
		