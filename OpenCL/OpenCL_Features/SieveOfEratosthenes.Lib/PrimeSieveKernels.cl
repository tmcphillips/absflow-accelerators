#ifndef T
#define T uint
#endif

__kernel void initialize_sieve(T max_prime, __global T * primes) {
	T i = get_global_id(0);
	if (i <= max_prime) primes[i] = (i < 2) ? 0 : 1;
}

__kernel void zero_composite(T max_prime, T prime, __global T * primes) {
	T gid = get_global_id(0);
	T i = (prime + gid) * prime;
	if (i <= max_prime) primes[i] = 0;
}

__kernel void reduce_nonzero_elements(__global T * primes, T max_prime, T offset) {
	T i = get_global_id(0) * offset * 2;
	T offsetI = i + offset;
	if (offsetI <= max_prime) primes[i] += primes[i + offset];
}

__kernel void prefix_sum_step(T element_count, T offset, __global T * sourceBuffer, __global T * destinationBuffer) {
	T i = get_global_id(0);
	if (i < element_count) {
		destinationBuffer[i] = (i >= offset) ? sourceBuffer[i] + sourceBuffer[i - offset] : sourceBuffer[i];
	}
}

__kernel void pack_indices_of_value_steps(__global T * packed_indices, __global T * values, T value_count) {
	T index = get_global_id(0) + 1;
	if (index <= value_count) {
		T value = values[index];
		bool is_step = (value > values[index - 1]);
		if (is_step) packed_indices[value - 1] = index;
	}
}