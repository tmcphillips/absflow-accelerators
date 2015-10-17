
/******************** NeedlemanWunsch 1 ***************************************
* 
* Summary:		This project is a simple implementation of the Needleman-Wunsch 
*               algorithm for finding the optimal complete alignment of two 
*				sequences.  
*
* Limitations:	(1) The lengths and elements of the two sequences to align are 
*					fixed during a run of the program.
*				(2) The scoring model comprises a single match score, a single
*					mismatch score, and a linear gap penalty only.
*
* Bugs:			This class has several bugs that are fixed in NeedlemanWunsch 2
*               and should not be used as the basis for new projects.
******************************************************************************/

#include <stdio.h>

int matchScore			=  2;
int mismatchScore		= -1;
int gapPenalty			=  2;

const int lengthA		=  6;
const int lengthB		=  8;

char* seqA;
char* seqB;

const int matrixWidth	= lengthA + 1;
const int matrixHeight	= lengthB + 1;

int score   [matrixWidth] [matrixHeight];
int vectorX [matrixWidth] [matrixHeight];
int vectorY [matrixWidth] [matrixHeight];

void computeScore(int i, int j) {

	int scoreIfGapInA = score[i][j-1] - gapPenalty;
	int scoreIfGapInB = score[i-1][j] - gapPenalty;
	int scoreIfMatch = score[i-1][j-1] + ((seqA[i-1] == seqB[j-1]) ? matchScore : mismatchScore);

	if (scoreIfMatch > scoreIfGapInA && scoreIfMatch > scoreIfGapInB) {
		score[i][j] = scoreIfMatch;
		vectorX[i][j] = -1;
		vectorY[i][j] = -1;
	} else if (scoreIfGapInA > scoreIfGapInB) {
		score[i][j] = scoreIfGapInA;
		vectorX[i][j] = 0;
		vectorY[i][j] = -1;
	} else {
		score[i][j] = scoreIfGapInB;
		vectorX[i][j] = -1;
		vectorY[i][j] = 0;
	}
}
 

void printMatrix(int m[matrixWidth][matrixHeight]) {

	// start matrix heading with two blank columns
	printf("        ");
	
	// complete matrix heading with the elements of sequence A 
	for (int i = 0; i < lengthA; i++) printf("%4c", seqA[i]);
	
	// print a blank line
	printf("\n\n");

	// loop over rows in matrix
	for (int j = 0; j < matrixHeight; j++) {
		
		// prefix matrix row with the next element of sequence B or a blank if this is the first row
		printf("%4c", j > 0 ? seqB[j-1] : ' ');
		
		// display all elements in the current matrix row 
		for (int i = 0; i < matrixWidth; i++) printf("%4d", m[i][j]);

		// print a blank line
		printf("\n\n");
	}

	// print a final blank line
	printf("\n");
}

void printGappedSequences() {

	const int bufferLength = lengthA + lengthB;

	char reverseBufferA[bufferLength];
	char reverseBufferB[bufferLength];

	int i = lengthA;
	int j = lengthB;
	int k = 0;
	int l = 0;

	while (i > 0 && j > 0) {
		
		if (vectorX[i][j] == 0) {
			reverseBufferA[k] = '-';
		} else {
			reverseBufferA[k] = seqA[i-1];
		}

		if (vectorY[i][j] == 0) {
			reverseBufferB[l] = '-';
		} else {
			reverseBufferB[l] = seqB[j-1];
		}

		int di = vectorX[i][j];
		int dj = vectorY[i][j];
		i += di;
		j += dj;
		k++;
		l++;
	}

	for (int m = k-1; m >= 0; m--) {
		printf("%c", reverseBufferA[m]);
	}
	printf("\n");
	for (int m = l-1; m >= 0; m--) {
		printf("%c", reverseBufferB[m]);
	}
	printf("\n");
}


int main(int argc, char* argv[]) {

	seqA	= "ATTAAG";
	seqB	= "AATCTAGC";

	for (int i = 0; i < matrixWidth; i++) {
		score[i][0] =  -i * gapPenalty;
	}

	for (int j = 0; j < matrixHeight; j++) {
		score[0][j] = -j * gapPenalty;
	}

	for (int i = 1; i < matrixWidth; i++) {
		for (int j = 1; j < matrixHeight; j++) {
			computeScore(i, j);
		}
	}
	
	printMatrix(score);
	printMatrix(vectorX);
	printMatrix(vectorY);
	printGappedSequences();

	return 0;
}
