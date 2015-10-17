#pragma once

#include <vector>

template <class ElementType> class DataMatrix {

public:

	DataMatrix(int m, int n) : rows{ m }, columns{ n }, elements{ m * n } {}
	ElementType& operator()(int i, int j) { return elements[i * columns + j]; }
	const int rows, columns;

private:

	std::vector<ElementType> elements;
};


