#include "stdafx.h"
#include "CppUnitTest.h"

#include "sequence_utilities.h"
#include "substitution_matrix.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

extern "C" int* two_param_nc_subs_matrix[];

namespace UtilitiesNativeTests
{
	TEST_CLASS(Test_SubstitutionMatrix)
	{
	public:
		
		TEST_METHOD(Test_CreateSubstitionMatrix_AdHocSubstitutionMatrix) {

			char* alphabet = "ATCG";
			
			int matrix0[] = { 2, -1, -1, -1};
			int matrix1[] = {-1,  2, -1, -1};
			int matrix2[] = {-1, -1,  2, -1};
			int matrix3[] = {-1, -1, -1,  2};

			int* matrix[] = {matrix0, matrix1, matrix2, matrix3};

			substitution_matrix_t* sm_matrix = sm_create(alphabet, matrix);

			Assert::AreEqual(4, (int)strlen(sm_matrix->alphabet));
			Assert::AreEqual(0, (int)sm_matrix->index['A']);
			Assert::AreEqual(1, (int)sm_matrix->index['T']);
			Assert::AreEqual(2, (int)sm_matrix->index['C']);
			Assert::AreEqual(3, (int)sm_matrix->index['G']);

			Assert::AreEqual(2, sm_get_substitution_score(sm_matrix, 'T', 'T'));
			Assert::AreEqual(-1, sm_get_substitution_score(sm_matrix, 'T', 'A'));

			sm_delete(sm_matrix);
		}

		TEST_METHOD(Test_CreateSubstitionMatrix_TwoParamNucSubstitutionMatrix) {

			substitution_matrix_t* sm_matrix = create_two_param_nuc_subs_matrix();

			Assert::AreEqual(4, (int)strlen(sm_matrix->alphabet));
			Assert::AreEqual(0, (int)sm_matrix->index['A']);
			Assert::AreEqual(1, (int)sm_matrix->index['T']);
			Assert::AreEqual(2, (int)sm_matrix->index['C']);
			Assert::AreEqual(3, (int)sm_matrix->index['G']);

			Assert::AreEqual(2, sm_get_substitution_score(sm_matrix, 'T', 'T'));
			Assert::AreEqual(-1, sm_get_substitution_score(sm_matrix, 'T', 'A'));

			sm_delete(sm_matrix);
		}

	};
}