#include "stdafx.h"
#include "HammingSequence.h"

namespace HammingSequence
{
	size_t hamming(uint64 max, uint64* h) {
		size_t last_2 = 0;
		size_t last_3 = 0;
		size_t last_5 = 0;
		h[0] = 1;
		int i = 0;
		while (true) {
			uint64 next = min(min(2 * h[last_2], 3 * h[last_3]), 5 * h[last_5]);
			if (next > max) break;
			h[++i] = next;
			while (h[last_2] * 2 <= next) ++last_2;
			while (h[last_3] * 3 <= next) ++last_3;
			while (h[last_5] * 5 <= next) ++last_5;
		}
		return i + 1;
	}
}