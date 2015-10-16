
namespace HammingSequence
{
	typedef unsigned long long uint64;
	inline uint64 min(uint64 a, uint64 b) { return a <= b ? a : b; }
	__declspec(dllexport) size_t hamming(uint64 max, uint64* h);
}