


template<typename T>
inline void swap(T a[], size_t i, size_t j) {
	T temp = a[j];
	a[j] = a[i];
	a[i] = temp;
}

template<typename T>
inline void orderTwoElements(T a[], size_t i, size_t j) {
	if (a[i] > a[j]) swap(a, i, j);
}

template<typename T>
size_t partition(T a[], size_t start, size_t end) {

	// find middle of subarray to partition without an overflow error
	size_t middle = start + (end - start) / 2;

	// do a blind bubble sort of the first, last, and middle elements
	orderTwoElements(a, start, middle);
	orderTwoElements(a, middle, end);
	orderTwoElements(a, start, middle);

	// take the resulting middle value as the pivot and put at end of subarray
	swap(a, middle, end);

	// scan through other elements of subarray and put values less than the
	// pivot value in the left (small) partition
	size_t lastSmall = start - 1;
	for (size_t i = start; i < end; ++i) {
		if (a[i] < a[end]) {
			++lastSmall;
			if (i != lastSmall)
				swap(a, lastSmall, i);
		}
	}

	// move pivot value to end of small partition
	++lastSmall;
	if (lastSmall != end)
		swap(a, lastSmall, end);

	// return index of last element in small partition
	return lastSmall;
}

template<typename T>
void quicksort(T a[], size_t start, size_t end) {
	if (end - start < 1) return;
	size_t pivot = partition(a, start, end);
	quicksort(a, start, pivot);
	quicksort(a, pivot + 1, end);
}
