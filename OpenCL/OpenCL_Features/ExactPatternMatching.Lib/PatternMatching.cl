#ifndef T
#define T uint
#endif

__kernel void find_matches(__global char * text, __global char * pattern, __global uint * matches, uint patternSize, uint max_mismatches) {
	T gid = get_global_id(0);
	uint matchFound = 1;
	uint mismatches = 0;
	for (uint i = 0; i < patternSize; ++i) {
		if (text[gid + i] != pattern[i] && ++mismatches > max_mismatches) {
			matchFound = 0;
			break;
		}
	}
	matches[gid] = matchFound;
}

__kernel void find_exact_matches(__global char * text, __global char * pattern, __global uint * matches, uint patternSize) {
	T gid = get_global_id(0);
	uint matchFound = 1;
	for (uint i = 0; i < patternSize; ++i) {
		if (text[gid + i] != pattern[i]) {
			matchFound = 0;
			break;
		}
	}
	matches[gid] = matchFound;
}

__kernel void prefix_sum_step(T element_count, T offset, __global T * sourceBuffer, __global T * destinationBuffer) {
	T i = get_global_id(0);
	if (i < element_count) {
		destinationBuffer[i] = (i >= offset) ? sourceBuffer[i] + sourceBuffer[i - offset] : sourceBuffer[i];
	}
}

__kernel void pack_indices_of_value_steps(__global T * packed_indices, __global T * values, T value_count) {
	T index = get_global_id(0);
	if (index < value_count) {
		T value = values[index];
		T previousValue = index > 0 ? values[index - 1] : 0;
		if (value > previousValue) packed_indices[value - 1] = index;
	}
}