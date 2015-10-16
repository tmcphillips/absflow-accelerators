#pragma once
#include "stdafx.h"
#include "PrimeSieve.h"

namespace SieveOfEratosthenes { namespace Native {

	template<typename T, bool enumerate = true>
	std::vector<T> findPrimesUpTo(T n, T* pCount = nullptr) {

		// create a vector for optionally enumerating the primes
		std::vector<T> * primes = new std::vector<T>();

		// create an array of bools indicating if the integer 
		// corresponding to the index has been determined not to be prime
		vector<bool> struck(n + 1);

		// initialize the prime number counter that is used only if 
		// the primes are not being enumerated
		T explicitCount = 0;

		// determine the upper bound on prime numbers with multiples <= n
		T sqrtN = (T) floor(sqrt(n));

		// scan integers less than the upper bound
		for (T i = 2; i <= sqrtN; ++i) {

			// skip the current number if it has been determined not to be prime
			if (struck[i]) continue;

			// record current number as a prime
			T currentPrime = i;
			if (enumerate)
				primes->push_back(currentPrime);
			else
				++explicitCount;

			// mark multiples of the current prime as not prime 
			for (T m = currentPrime * currentPrime; m <= n; m += currentPrime) {
				if (!struck[m]) struck[m] = true;
			}
		}

		// scan integers greater than sqrt(n) for numbers not determined to be composite 
		for (T i = sqrtN + 1; i <= n; ++i) {
			if (!struck[i]) {
				if (enumerate)
					primes->push_back(i);
				else
					++explicitCount;
			}
		}

		// optionally return count of primes through return parameter
		if (pCount != nullptr) *pCount = enumerate ? (T) primes->size() : explicitCount;

		// return vector of enumerated primes (empty if enumeration == false)
		return *primes;
	}


	template<typename T, bool enumerate = true>
	std::vector<T> findPrimesUpTo_Odd(T n, T* pCount = nullptr) {

		// number of odd numbers less than n
		T odds = (n + 1) / 2;

		// create a vector for optionally enumerating the primes
		std::vector<T> * primes = new vector<T>();

		// create an vector of bools indicating if the odd number 
		// corresponding to the index has been determined not to be prime
		std::vector<bool> struck(odds + 1);

		// record 2 as a prime number
		T explicitCount = 1;
		primes->push_back((T) 2);

		// determine the upper bound on prime numbers with multiples <= n
		T sqrtN = (T) floor(sqrt(n));

		// scan odd integers less than the upper bound
		for (T i = 2; i <= (sqrtN + 1) / 2; ++i) {

			// skip the current number if it has been determined not to be prime
			if (struck[i]) continue;

			// record current number as a prime
			T currentPrime = 2 * i - 1;
			if (enumerate)
				primes->push_back(currentPrime);
			else
				++explicitCount;

			// mark odd multiples of the current prime as not prime
			for (T m = currentPrime * currentPrime; m <= n; m += currentPrime) {
				if (m % 2) {
					T oddIndex = (m + 1) / 2;
					if (!struck[oddIndex]) struck[oddIndex] = true;
				}
			}
		}

		// scan odds greater than sqrt(n) for numbers not determined to be composite 
		for (T i = (sqrtN + 1) / 2 + 1; i <= odds; ++i) {
			if (!struck[i]) {
				if (enumerate)
					primes->push_back(2 * i - 1);
				else
					++explicitCount;
			}
		}

		// optionally return count of primes through return parameter
		if (pCount != nullptr) *pCount = enumerate ? (T) primes->size() : explicitCount;

		// return vector of enumerated primes (empty if enumeration == false)
		return *primes;
	}

}}