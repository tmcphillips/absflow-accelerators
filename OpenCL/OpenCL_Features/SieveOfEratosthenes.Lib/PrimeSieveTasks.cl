#ifndef INDEX_T
#define INDEX_T uint
#endif

#ifndef VALUE_T
#define VALUE_T uchar
#endif

__kernel void initialize_all_integers(INDEX_T max, __global VALUE_T * primes) {
	for (INDEX_T i = 1; i <= max; ++i) primes[i] = 1;
}

//__kernel void clear_all_composites_128(uint max, __global prime_value_t * primes) {
//	
//	uint count = max / 128;
//	uint remainder = max % 128;
//
//	ulong16* p = (ulong16*) primes;
//	for (uint i = 0; i < count; ++i) *p++ = 0;
//
//	uchar* q = (uchar*) p;
//	for (uint i = 0; i < remainder; ++i) *q++ = 0;
//}

__kernel void zero_all_composites(INDEX_T max, __global VALUE_T * primes) {

	INDEX_T sqrtMax = floor(sqrt((float) max));

	// scan integers less than the upper bound
	for (INDEX_T i = 2; i <= sqrtMax; ++i) {

		// skip the current number if it has been determined not to be prime
		if (primes[i]) {
			// mark multiples of the current prime as not prime 
			INDEX_T currentPrime = i;
			for (INDEX_T m = currentPrime * currentPrime; m <= max; m += currentPrime) {
				if (primes[m]) primes[m] = 0;
			}
		}
	}
}

__kernel void count_all_primes(INDEX_T max, __global VALUE_T * primes, __global INDEX_T * primesCount) {
	INDEX_T count = 0;
	for (INDEX_T i = 2; i <= max; ++i) {
		if (primes[i]) ++count;
	}
	*primesCount = count;
}
